//
//  FilePathsInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/07/03.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class FilePathsInterfaceController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    
    lazy var items: NSArray = {
        // TODO: Filemanager確認
        
        let defaultFileManager: NSFileManager = NSFileManager.defaultManager()
        
        let documentDirectory: NSArray
        = defaultFileManager.URLsForDirectory(NSSearchPathDirectory.DocumentationDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let documentDirectoryPath = documentDirectory.firstObject as! String

        
        let cachDirectory: NSArray
        = defaultFileManager.URLsForDirectory(NSSearchPathDirectory.CachesDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let cachDirectoryPath = cachDirectory.firstObject as! String
        
        let tmpDirectory = NSTemporaryDirectory()
        
        return NSArray(objects: documentDirectory, cachDirectory, tmpDirectory)
        }()

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.table.setNumberOfRows(self.items.count, withRowType: "FilePathsListCell")
            self.items.enumerateObjectsUsingBlock { (object: AnyObject!, index: NSInteger, stop: UnsafeMutablePointer<ObjCBool> ) -> Void in
                
                let cell: FilePathsListCell = self.table.rowControllerAtIndex(index)! as! FilePathsListCell
                let caption = self.items[index] as! String
                cell.configureCell(caption)
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
