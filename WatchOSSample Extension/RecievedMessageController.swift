//
//  RecievedMessageController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/07/05.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class RecievedMessageController: WKInterfaceController {

    
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        let message = context as! String
        self.messageLabel.setText(message)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
