//
//  TopInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class TopInterfaceController: WKInterfaceController, WCSessionDelegate  {

    @IBOutlet var table: WKInterfaceTable!
    
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("WatchResource", ofType:"plist" )
        let list = NSArray(contentsOfFile: filePath!)
        return list!
        }()

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "presentImageView:", name: "MessageDataRecieved", object: nil)
        notificationCenter.addObserver(self, selector: "presentMessageView:", name: "MessageRecieved", object: nil)
        notificationCenter.addObserver(self, selector: "presentMessageView:", name: "TransferUserInfoRecieved", object: nil)
        notificationCenter.addObserver(self, selector: "presentMessageView:", name: "ApplicationContextRecieved", object: nil)

    }

    override func willActivate() {
        super.willActivate()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.table.setNumberOfRows(self.items.count, withRowType: "WatchOSSampleListCell")
            self.items.enumerateObjectsUsingBlock { (object: AnyObject!, index: NSInteger, stop: UnsafeMutablePointer<ObjCBool> ) -> Void in
                
                let cell: WatchOSSampleListCell = self.table.rowControllerAtIndex(index)! as!WatchOSSampleListCell
                
                let item = self.items[index] as! NSDictionary
                let title = item["FunctionName"] as! String
                let caption = item["ClassName"] as! String
                
                cell.configureCell(title, caption: caption)
            }
        }
    }
    
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        let item = self.items[rowIndex] as! NSDictionary
        let prefix = item["FunctionName"] as! String
        
        self.pushControllerWithName("\(prefix)InterfaceController", context: nil)
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    // MARK: Private 
    func presentImageView(notification:NSNotification) {
        guard let notificationObject = notification.object else {return}
        let imageData = notificationObject as! NSData
        let image = UIImage(data: imageData)
        self.presentControllerWithName("RecievedImageController", context: image)
    }
    
    func presentMessageView(notification:NSNotification) {
        guard let notificationObject = notification.object else { return }
        let message = notificationObject as! String
        self.presentControllerWithName("RecievedMessageController", context: message)
    }


}
