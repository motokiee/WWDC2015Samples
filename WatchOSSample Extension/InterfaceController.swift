//
//  InterfaceController.swift
//  WatchOSSample Extension
//
//  Created by Motoki on 2015/06/20.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var picker: WKInterfacePicker!

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        let hapticNames = [
            "Notification",
            "DirectionUp",
            "DirectionDown",
            "Success",
            "Failure",
            "Retry",
            "Start",
            "Stop",
            "Click",]
        
        var pickerItems: [WKPickerItem] = [WKPickerItem]()
        
        for i in 0...8 {
        
            let item = WKPickerItem()
            item.title = hapticNames[i]
            item.caption = "WKHapticType"
            pickerItems.append(item)
        }
        
        self.picker.setItems(pickerItems)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func action(value: Int) {
        let device = WKInterfaceDevice()
        device.playHaptic(WKHapticType(rawValue: value)!)
    }
    
    @IBAction func connect() {
        
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
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
