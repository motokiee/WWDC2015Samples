//
//  HapticInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class HapticInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    let items: NSArray = [
        "Notification",
        "DirectionUp",
        "DirectionDown",
        "Success",
        "Failure",
        "Retry",
        "Start",
        "Stop",
        "Click"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.table.setNumberOfRows(self.items.count, withRowType: "HapticListCell")
            self.items.enumerateObjectsUsingBlock { (object: AnyObject!, index: NSInteger, stop: UnsafeMutablePointer<ObjCBool> ) -> Void in
                
                let cell: HapticListCell = self.table.rowControllerAtIndex(index)! as! HapticListCell
                cell.configureCell(self.items.objectAtIndex(index) as! String)
            }
        }
    }
    
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let device = WKInterfaceDevice()
        device.playHaptic(WKHapticType(rawValue: rowIndex)!)
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
