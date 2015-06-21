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
    let session = WCSession.defaultSession()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        session.delegate = self
        session.activateSession()
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
    
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Message Did Recieve", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.window?.rootViewController!.presentViewController(alert, animated: true, completion: {
                
            })
        }
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
                
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Message Did Recieve", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.window?.rootViewController!.presentViewController(alert, animated: true, completion: {
                
            })
        }
    }
    
}