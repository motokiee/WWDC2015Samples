//
//  TopInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class TopInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("WatchResource", ofType:"plist" )
        let list = NSArray(contentsOfFile: filePath!)
        return list!
        }()

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        super.willActivate()
        
        self.table.setNumberOfRows(items.count, withRowType: "WatchOSSampleListCell")
        items.enumerateObjectsUsingBlock { (object: AnyObject!, index: NSInteger, stop: UnsafeMutablePointer<ObjCBool> ) -> Void in
            
            let cell: WatchOSSampleListCell = self.table.rowControllerAtIndex(index)! as!WatchOSSampleListCell
            
            let item = self.items[index] as! NSDictionary
            let title = item["FunctionName"] as! String
            let caption = item["ClassName"] as! String
            
            cell.configureCell(title, caption: caption)
        }
        
    }
    
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        let item = self.items[rowIndex] as! NSDictionary
        let prefix = item["FunctionName"] as! String
        
        self.pushControllerWithName("\(prefix)InterfaceController", context: nil)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
