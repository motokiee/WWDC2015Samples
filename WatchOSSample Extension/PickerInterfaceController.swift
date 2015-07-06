//
//  PickerInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation

class PickerInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var group: WKInterfaceGroup!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
                
        var pickerItems: [WKPickerItem] = [WKPickerItem]()
        
        for i in 0...59 {
            let item = WKPickerItem()
            item.title = String(i)
            item.caption = "Image No."
            pickerItems.append(item)
        }
        
        self.group.setBackgroundImage(UIImage(named: "Circle0"))
        self.picker.setCoordinatedAnimations([self.group])
        self.picker.setItems(pickerItems)
    }
    
    override func willActivate() {

        super.willActivate()
        
        dispatch_async(dispatch_get_main_queue()) {
            
            var images: [UIImage] = [UIImage]()
            
            for i in 0...59 {
                
                let imageName = "Circle" + String(i)
                let image = UIImage(named: imageName)
                images.append(image!)
            }
            
            let progressImages = UIImage.animatedImageWithImages(images, duration: 1.0)
            self.group.setBackgroundImage(progressImages)
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func action(value: Int) {
        let device = WKInterfaceDevice()
        device.playHaptic(WKHapticType(rawValue: value)!)
    }
}
