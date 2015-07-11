//
//  AppDelegate.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/17.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit
import CoreSpotlight
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    
    var window: UIWindow?
    let watchSession = WCSession.defaultSession()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.watchSession.delegate = self
        self.watchSession.activateSession()
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
    }
    
    
    // LocalNotificationのText Inputから呼び出す
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        
        if identifier == "UIKitSampleTextInput" {
            let replyString = responseInfo[UIUserNotificationActionResponseTypedTextKey]
            NSNotificationCenter.defaultCenter().postNotificationName("UIKitSampleTextInputNotification", object: replyString)
        }
        
        completionHandler()
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity,
        restorationHandler: ([AnyObject]?) -> Void) -> Bool
    {
        if userActivity.activityType == CSSearchableItemActionType {
            
            if let title: String = userActivity.title {
                
                let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.window?.rootViewController!.presentViewController(alert, animated: true, completion: {
                    
                })
            }
            
        }
        return true
    }
    
    
    // MARK: WCSessionDelegate
    func sessionWatchStateDidChange(session: WCSession) {
    }
    
    // called when reachability status changed
    func sessionReachabilityDidChange(session: WCSession) {
        
        let title = self.watchSession.correspondMessage(WatchSessionStateType.Reachable)
        dispatch_async(dispatch_get_main_queue()) {
            
            let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.window?.rootViewController!.presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Did Recieve ApplicationContext", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.window?.rootViewController!.presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func session(session: WCSession, didReceiveFile file: WCSessionFile) {
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Did Recieve File", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.window?.rootViewController!.presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Did Recieve UserInfo", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.window?.rootViewController!.presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        guard let recievedMessage = message["Messagekey"] where recievedMessage is String else {return}
        
        switch UIApplication.sharedApplication().applicationState {
            
        case UIApplicationState.Active:
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "Message Recieved", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.window?.rootViewController!.presentViewController(alert, animated: true, completion:nil)
            }
            let replyInfo: [String : AnyObject] = ["ReplyInfo": "iPhone received Message in Foreground"]
            replyHandler(replyInfo)
            
            
        case UIApplicationState.Background:
            let replyInfo: [String : AnyObject] = ["ReplyInfo": "iPhone received Message in Background"]
            replyHandler(replyInfo)
            
        case UIApplicationState.Inactive:
            let replyInfo: [String : AnyObject] = ["ReplyInfo": "iPhone received Message in Inactive"]
            replyHandler(replyInfo)
        }
    }
    
    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        
        switch UIApplication.sharedApplication().applicationState {
            
        case UIApplicationState.Active:
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "Message Data Recieved", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.window?.rootViewController!.presentViewController(alert, animated: true, completion:nil)
            }
            
            let replyInfo: [String : AnyObject] = ["ReplyInfo": "iPhone received Message Data in Foreground"]
            let replyData = NSKeyedArchiver.archivedDataWithRootObject(replyInfo)
            replyHandler(replyData)
            
        case UIApplicationState.Background:
            let replyInfo: [String : AnyObject] = ["ReplyInfo": "iPhone received Message Data in Background"]
            let replyData = NSKeyedArchiver.archivedDataWithRootObject(replyInfo)
            replyHandler(replyData)
            
        case UIApplicationState.Inactive:
            let replyInfo: [String : AnyObject] = ["ReplyInfo": "iPhone received Message Data in Inactive"]
            let replyData = NSKeyedArchiver.archivedDataWithRootObject(replyInfo)
            replyHandler(replyData)

        }
    }
    
    
}

extension WCSession {
    // MARK: Private
    func correspondMessage(stateType: WatchSessionStateType) -> String {
        
        let title: String
        
        switch stateType {
        case .Paired:
            if self.paired {
                title = "ペアリング済み"
            } else {
                title = "ペアリングされていません"
            }
        case .WatchAppInstalled:
            if self.watchAppInstalled {
                title = "Watch app インストール済み"
            } else {
                title = "Watch appがインストールされていません"
            }
        case .ComplicationEnabled:
            if self.complicationEnabled {
                title = "complication設定済み"
            } else {
                title = "complicationが設定されていません"
            }
            
        case .Reachable:
            if self.reachable {
                title = "Apple Watchと通信可能"
            } else {
                title = "Apple Watchと通信できません"
            }
            
        }
        
        return title
    }
}