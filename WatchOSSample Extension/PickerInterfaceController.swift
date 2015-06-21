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
    }
    
    override func willActivate() {

        super.willActivate()
        
        var images: [UIImage] = [UIImage]()
        var pickerItems: [WKPickerItem] = [WKPickerItem]()
        
        for i in 0...59 {
            
            let imageName = "cobalt_watch_background to_3m_" + String(i)
            let image = UIImage(named: imageName)
            images.append(image!)
            
            let item = WKPickerItem()
            item.title = String(i)
            item.caption = "Image No."
            pickerItems.append(item)
        }
        
        let progressImages = UIImage.animatedImageWithImages(images, duration: 1.0)
        self.group.setBackgroundImage(progressImages)
        self.picker.setCoordinatedAnimations([self.group])
        self.picker.setItems(pickerItems)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func action(value: Int) {
        let device = WKInterfaceDevice()
        device.playHaptic(WKHapticType(rawValue: value)!)
    }
   /*
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
*/
}
