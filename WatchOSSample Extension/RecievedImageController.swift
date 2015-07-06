//
//  RecievedImageController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/07/05.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class RecievedImageController: WKInterfaceController {

    @IBOutlet var imageView: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let image = context as! UIImage
        self.imageView.setImage(image)
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
