//
//  WatchConnectivityViewController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/07/02.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit
import WatchConnectivity

enum WatchSessionStateType: Int{
    case Paired
    case WatchAppInstalled
    case ComplicationEnabled
    case Reachable
}

class WatchConnectivityViewController: UITableViewController, WCSessionDelegate {

    let watchSession = WCSession.defaultSession()
    
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("WatchConnectivity", ofType:"plist" )
        let list = NSArray(contentsOfFile: filePath!)
        return list!
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.watchSession.delegate = self
        self.watchSession.activateSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath)
        cell.textLabel?.text = items.objectAtIndex(indexPath.row) as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if WCSession.isSupported() {
            
            defer {
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
            
            var title:String?
            
            switch indexPath.row {
                
            case 0:
                title = self.correspondMessage(self.watchSession.paired, stateType: WatchSessionStateType.Paired)

            case 1:
                title = self.correspondMessage(self.watchSession.watchAppInstalled, stateType: WatchSessionStateType.WatchAppInstalled)
                
            case 2:
                title = self.correspondMessage(self.watchSession.complicationEnabled, stateType: WatchSessionStateType.ComplicationEnabled)

            case 3:
                title = self.correspondMessage(self.watchSession.reachable, stateType: WatchSessionStateType.Reachable)
                
            case 4:
                
                if self.watchSession.reachable {
                    
                    let message = ["Messagekey": "Message from iPhone"]
                    self.watchSession.sendMessage(message, replyHandler: { (replyMessage) -> Void in
                        
                        let title:[String:String] = replyMessage as! [String:String]
                        
                        let alert = UIAlertController(title: title["ReplyInfo"], message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                        }, errorHandler: { (error) -> Void in
                            let alert = UIAlertController(title: "Error Description", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                    })
                } else {
                    title = self.correspondMessage(self.watchSession.reachable, stateType: WatchSessionStateType.Reachable)
                    break
                }
                
            case 5:
                
                if self.watchSession.reachable {
                    
                    let data = NSData(data: UIImagePNGRepresentation(UIImage(named: "apple")!)!)
                    // !!!: データが大きい場合
                    //let data = NSData(data: UIImagePNGRepresentation(UIImage(named: "moscone_west")!)!)
                    self.watchSession.sendMessageData(data, replyHandler: { (data) -> Void in
                        
                        let string = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [String:String]
                        
                        let alert = UIAlertController(title: string["ReplyInfo"], message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                        }, errorHandler: { (error) -> Void in
                            let alert = UIAlertController(title: "Error Description", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                    })
                } else {
                    title = self.correspondMessage(self.watchSession.reachable, stateType: WatchSessionStateType.Reachable)
                    break
                }
                
            case 6:
                // FIXME: applicationContext
                let applicationContext = ["ApplicationContext" : NSDate().description]
                
                do {
                    try self.watchSession.updateApplicationContext(applicationContext)
                    let printMessage = self.watchSession.applicationContext["ApplicationContext"]
                    print("\(printMessage)")
                } catch {
                    
                    let alert = UIAlertController(title: "ApplicationContext Update Error", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            case 7:
                // 送信側
                guard let filePath = NSBundle.mainBundle().pathForResource("Federighi_with_me", ofType:"jpg") else {return}
                let fileURLPath = NSURL(fileURLWithPath: filePath)
                self.watchSession.transferFile(fileURLPath, metadata: ["TransferFile":"transferFile"])

            case 8:
                let userInfo = ["UserInfo":"transferUserInfo"]
                self.watchSession.transferUserInfo(userInfo)
                
            case 9:
                
                if self.watchSession.complicationEnabled {
                    let complicationUserInfo = ["ComplicationUserInfo":"transferCurrentComplicationUserInfo"]
                    self.watchSession.transferCurrentComplicationUserInfo(complicationUserInfo)
                } else {
                    title = self.correspondMessage(self.watchSession.complicationEnabled, stateType: WatchSessionStateType.ComplicationEnabled)
                    break
                }

                
            case 10:

                let errors = [
                    ("GenericError",WCErrorCode.GenericError.rawValue),
                    ("SessionNotSupported",WCErrorCode.SessionNotSupported.rawValue),
                    ("SessionMissingDelegate",WCErrorCode.SessionMissingDelegate.rawValue),
                    ("SessionNotActivated",WCErrorCode.SessionNotActivated.rawValue),
                    ("DeviceNotPaired",WCErrorCode.DeviceNotPaired.rawValue),
                    ("WatchAppNotInstalled",WCErrorCode.WatchAppNotInstalled.rawValue),
                    ("NotReachable",WCErrorCode.NotReachable.rawValue),
                    ("InvalidParameter",WCErrorCode.InvalidParameter.rawValue),
                    ("PayloadTooLarge",WCErrorCode.PayloadTooLarge.rawValue),
                    ("PayloadUnsupportedTypes",WCErrorCode.PayloadUnsupportedTypes.rawValue),
                    ("MessageReplyFailed",WCErrorCode.MessageReplyFailed.rawValue),
                    ("MessageReplyTimedOut",WCErrorCode.MessageReplyTimedOut.rawValue),
                    ("FileAccessDenied",WCErrorCode.FileAccessDenied.rawValue),
                    ("DeliveryFailed",WCErrorCode.DeliveryFailed.rawValue)
                ]
                
                var message:String = ""
                
                for error in errors {
                    message += "\(error.0) == \(error.1)\n"
                }

                let alert = UIAlertController(title: "WCErrorCode rawValue", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: {
                })
                
            default:
                abort()
            }

            if title != nil {
                let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: {
                })
            }
        }
    }
    
    // MARK: Private
    func correspondMessage(state: Bool, stateType: WatchSessionStateType) -> String {
        
        let title: String
        
        switch stateType {
        case .Paired:
            if state {
                title = "ペアリング済み"
            } else {
                title = "ペアリングされていません"
            }
        case .WatchAppInstalled:
            if state {
                title = "Watch app インストール済み"
            } else {
                title = "Watch appがインストールされていません"
            }
        case .ComplicationEnabled:
            if state {
                title = "complication設定済み"
            } else {
                title = "complicationが設定されていません"
            }
            
        case .Reachable:
            if state {
                title = "Apple Watchと通信可能"
            } else {
                title = "Apple Watchと通信できません"
            }
            
        }
        
        return title
    }

    // MARK: WCSessionDelegate
    
    func sessionWatchStateDidChange(session: WCSession) {
        // paired, watchAppInstalled, complicationEnabled, or watchDirectoryURLあたりの状態が変更されたら呼ばれる
        // The session object calls this method when the value in the paired, watchAppInstalled, complicationEnabled, or watchDirectoryURL properties of the WCSession object changes.
    }
    
    func sessionReachabilityDidChange(session: WCSession) {
        // Reachableの状態が変化したら呼ばれる
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print("\(applicationContext)")
    }
    
    func session(session: WCSession, didFinishFileTransfer fileTransfer: WCSessionFileTransfer, error: NSError?) {
        
        if (error != nil) {
            print("\(error)")
        }
        
        print("file transfer is finished")

    }
    
    
    func session(session: WCSession, didFinishUserInfoTransfer userInfoTransfer: WCSessionUserInfoTransfer, error: NSError?) {
    }
    
    func session(session: WCSession, didReceiveFile file: WCSessionFile) {
    }

    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
    }

    // MARK: WCSessionDelegate - message
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Message Did Recieve", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
        }
    }
    
    // !!!: 対になるアプリからレスポンスを受け取る場合はこちらを使用する
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Message Did Recieve", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: {
            })
        }
    }
    
    
}