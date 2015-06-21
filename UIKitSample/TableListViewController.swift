//
//  TableListViewController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/17.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit
import WatchConnectivity

class TableListViewController: UITableViewController, WCSessionDelegate {
    
    var watchSession = WCSession.defaultSession()
    
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("Resource", ofType:"plist" )
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
        
        // LocalNotification
        if indexPath.row == 0 {
            let coreSpotlightViewController =
            UIStoryboard.instantiateViewController(
                "CoreSpotlightViewController",
                viewControllerName: "CoreSpotlightViewController") as! CoreSpotlightViewController
            self.showViewController(coreSpotlightViewController, sender: self)
        }
        
        // Watch Connectivity
        if indexPath.row == 1 {
            if WCSession.isSupported() {
                let session = WCSession.defaultSession()
                session.delegate = self
                session.activateSession()
                
                let message = ["message": "Messagekey"]
                session.sendMessage(message, replyHandler: { (replyMassage) -> Void in
                    print("\(replyMassage)")
                    
                    }, errorHandler: { (error) -> Void in
                        print("error")
                })
            }
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }

        // SafariViewController
        if indexPath.row == 2 {
            let safariViewController = UIStoryboard.instantiateViewController("SafariViewController", viewControllerName: "SafariViewController")
            self.showViewController(safariViewController, sender: self)
        }
        
        // LocalNotification
        if indexPath.row == 3 {
            let localNotificationSampleViewController =
            UIStoryboard.instantiateViewController(
                "LocalNotificationSampleViewController",
                viewControllerName: "LocalNotificationSampleViewController") as! LocalNotificationSampleViewController
            self.showViewController(localNotificationSampleViewController, sender: self)
        }
        
        // LocalNotification
        if indexPath.row == 4 {
            let sanfranciscoViewController =
            UIStoryboard.instantiateViewController(
                "SanFranciscoViewController",
                viewControllerName: "SanFranciscoViewController") as! SanFranciscoViewController
            self.showViewController(sanfranciscoViewController, sender: self)
        }
    }
    
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Message Did Recieve", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Message Did Recieve", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
        }
    }
    
}