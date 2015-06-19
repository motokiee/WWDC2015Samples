//
//  LocalNotificationSampleViewController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/17.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit

class LocalNotificationSampleViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // responseを受け取ってlabelの更新
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "replaceLabelText:", name: "UIKitSampleTextInputNotification", object: nil)
        
        // 通知の許可を取る
        let application = UIApplication.sharedApplication()
        application.registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert, UIUserNotificationType.Badge],
                categories: nil)
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    @IBAction func createLocalNotification(sender: AnyObject) {

        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 3)
        localNotification.alertBody = "AlertBody"
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.applicationIconBadgeNumber = 3
        localNotification.category = "UIKitSample"
        
        self.registerSettingsAndCategories()
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    private func registerSettingsAndCategories() {
        
        let replyAction = UIMutableUserNotificationAction()
        replyAction.title = "Reply"
        replyAction.identifier = "UIKitSampleTextInput"
        replyAction.activationMode = .Background
        replyAction.authenticationRequired = false
        replyAction.behavior = .TextInput
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "UIKitSample"
        category.setActions([replyAction], forContext: .Default)
        
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert], categories: [category])
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func replaceLabelText(notification: NSNotification) {
        self.label.text = notification.object as? String
    }
}