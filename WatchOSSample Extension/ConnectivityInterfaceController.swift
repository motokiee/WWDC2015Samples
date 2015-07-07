//
//  ConnectivityInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class ConnectivityInterfaceController: WKInterfaceController {

    let session:WCSession = WCSession.defaultSession()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
     
        // セッション開始可能か確認
        if WCSession.isSupported() {
            self.session.activateSession()
        }
        
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // MARK: Action
    @IBAction func updateApplicationContext() {
        let applicationContext = ["ApplicationContext" : NSDate().description]
        do {
            try self.session.updateApplicationContext(applicationContext)
        } catch {
            print("error")
        }
    }
    
    @IBAction func transferUserInfo() {
        let userInfo = ["UserInfo":"transferUserInfo"]
        self.session.transferUserInfo(userInfo)
    }
    
    @IBAction func transferFile() {
        
        guard let filePath = NSBundle.mainBundle().pathForResource("twizzlers", ofType:"jpg") else {return}
        
        // !!!:NSURL(fileURLWithPath:)を使用すること
        let fileURLPath = NSURL(fileURLWithPath: filePath)
        self.session.transferFile(fileURLPath, metadata: ["TransferFile":"twizzlers"])
    }
    
    @IBAction func sendMessage() {

        if self.session.reachable {
            let message = ["Messagekey": "message"]
            self.session.sendMessage(message, replyHandler: { (replyMassage) -> Void in
                print("\(replyMassage)")
                }, errorHandler: { (error) -> Void in
                    print("error")
            })
        }
    }
    
    @IBAction func sendMessageData() {
        
        let data = NSData(data: UIImagePNGRepresentation(UIImage(named: "apple")!)!)
        self.session.sendMessageData(data, replyHandler: { (data) -> Void in
                print("success")
            }, errorHandler: { (error) -> Void in
                print("error")
        })
    }
}