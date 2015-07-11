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
                title = self.watchSession.correspondMessage(WatchSessionStateType.Paired)

            case 1:
                title = self.watchSession.correspondMessage(WatchSessionStateType.WatchAppInstalled)
                
            case 2:
                title = self.watchSession.correspondMessage(WatchSessionStateType.ComplicationEnabled)

            case 3:
                title = self.watchSession.correspondMessage(WatchSessionStateType.Reachable)
                
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
                    title = self.watchSession.correspondMessage(WatchSessionStateType.Reachable)
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
                    title = self.watchSession.correspondMessage(WatchSessionStateType.Reachable)
                    break
                }
                
            case 6:
                let applicationContext = ["ApplicationContext" : NSDate().description]
                
                do {
                    try self.watchSession.updateApplicationContext(applicationContext)
                } catch {
                    let alert = UIAlertController(title: "ApplicationContext Update Error", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            case 7:
                guard let filePath = NSBundle.mainBundle().pathForResource("Affogato", ofType:"jpg") else {return}
                
                // !!!:NSURL(fileURLWithPath:)を使用すること
                let fileURLPath = NSURL(fileURLWithPath: filePath)
                self.watchSession.transferFile(fileURLPath, metadata: ["TransferFile":"Federighi_with_me"])

            case 8:
                let userInfo = ["UserInfo":"transferUserInfo"]
                self.watchSession.transferUserInfo(userInfo)
                
            case 9:
                // compliaction関連
                if self.watchSession.complicationEnabled {
                    let complicationUserInfo = ["ComplicationUserInfo":"transferCurrentComplicationUserInfo"]
                    self.watchSession.transferCurrentComplicationUserInfo(complicationUserInfo)
                } else {
                    title = self.watchSession.correspondMessage(WatchSessionStateType.ComplicationEnabled)
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
                
                self.presentViewController(alert, animated: true, completion:nil)
                
            default:
                return
            }

            if title != nil {
                let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion:nil)
            }
        }
    }

}