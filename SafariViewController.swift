//
//  SafariViewController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit
import SafariServices

class SafariViewController: UIViewController, SFSafariViewControllerDelegate {

    var isFirstAppear: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if !self.isFirstAppear {
            let safariViewController
            = SFSafariViewController(URL: NSURL(string: "https://developer.apple.com/")!)
            safariViewController.delegate = self

            self.presentViewController(safariViewController, animated: true) { () -> Void in
                self.isFirstAppear = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: SFSafariViewControllerDelegate
    /*
    func safariViewController(controller: SFSafariViewController, activityItemsForURL URL: NSURL, title: String?) -> [UIActivity] {
    
    }
    */
    
    /*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the client should dismiss the view controller modally. */
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        
        controller.dismissViewControllerAnimated(true) { () -> Void in
            print("did finish")
        }
    }
}