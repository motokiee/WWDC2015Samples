//
//  AlertAndActionInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/07/03.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class AlertAndActionInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func presentAlert() {
        self.presentAlertControllerWithTitle("Alert", message: nil, preferredStyle: WKAlertControllerStyle.Alert, actions: self.setupActions())
    }
    
    @IBAction func presentAction() {
        self.presentAlertControllerWithTitle("Action", message: nil, preferredStyle: WKAlertControllerStyle.ActionSheet, actions: self.setupActions())
    }
    
    func setupActions() -> [WKAlertAction] {

        let okAction = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler:{ WKAlertActionHandler in
            self.dismissController()
        })
        
        let cancelAction = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Cancel, handler:{ WKAlertActionHandler in
            self.dismissController()
        })
        
        // ActionSheetにはもともとCancelが用意されているので追加しても表示されない
        let deleteAction = WKAlertAction(title: "Delete", style: WKAlertActionStyle.Destructive, handler:{ WKAlertActionHandler in
            self.dismissController()
        })
        
        return [okAction, cancelAction, deleteAction]
    }

}
