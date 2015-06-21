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

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
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

    @IBAction func connect() {
        
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.activateSession()
            
            let device = WKInterfaceDevice()
            device.playHaptic(WKHapticType.Success)
            
            let message = ["message": "Messagekey"]
            session.sendMessage(message, replyHandler: { (replyMassage) -> Void in
                print("\(replyMassage)")
                }, errorHandler: { (error) -> Void in
                    print("error")
            })
            
        }
    }

    
}