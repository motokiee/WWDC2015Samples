//
//  Utility.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/17.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    /**
    StoryboardからUIViewControllerを取り出す
    
    :param: storyboardName     取り出すstoryboard名
    :param: viewControllerName 取り出したいviewcontroller名
    
    :returns: viewController
    */
    class func instantiateViewController(storyboardName: String, viewControllerName: String) -> UIViewController {
        
        let stroyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let viewController: UIViewController
        = stroyboard.instantiateViewControllerWithIdentifier(viewControllerName) as UIViewController
        
        return viewController
    }
}