//
//  SFCompactInterfaceController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import Foundation


class SFCompactInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("SFCompactFontWeight", ofType:"plist" )
        let list = NSArray(contentsOfFile: filePath!)
        return list!
        }()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        super.willActivate()
        
        self.table.setNumberOfRows(items.count, withRowType: "SFCompactListCell")
        items.enumerateObjectsUsingBlock { (object: AnyObject!, index: NSInteger, stop: UnsafeMutablePointer<ObjCBool> ) -> Void in
            
            let cell: SFCompactListCell = self.table.rowControllerAtIndex(index)! as! SFCompactListCell

            let item = self.items[index] as! String
            
            var weight = UIFontWeightUltraLight
            
            if item == "UIFontWeightUltraLight" {
                weight = UIFontWeightUltraLight
            } else if item == "UIFontWeightThin" {
                weight = UIFontWeightThin
            } else if item == "UIFontWeightLight" {
                weight = UIFontWeightLight
            } else if item == "UIFontWeightRegular" {
                weight = UIFontWeightRegular
            } else if item == "UIFontWeightMedium" {
                weight = UIFontWeightMedium
            } else if item == "UIFontWeightSemibold" {
                weight = UIFontWeightSemibold
            } else if item == "UIFontWeightBold" {
                weight = UIFontWeightBold
            } else if item == "UIFontWeightHeavy" {
                weight = UIFontWeightHeavy
            } else if item == "UIFontWeightBlack" {
                weight = UIFontWeightBlack
            }
            
            
            let japaneseString = "あのハートイーヴォのすきとおった風、夏でもそこに冷たさをもつ青いそら、美しい..."
            let attributedTitleString = NSMutableAttributedString(string: japaneseString)
            attributedTitleString.addAttribute(
                NSFontAttributeName,
                value: UIFont.systemFontOfSize(20.0, weight: weight),
                range: NSMakeRange(0 , attributedTitleString.length))
            
            let englishString = "The quick brown fox jumps over the lazy dog."
            let attributedCaptionString = NSMutableAttributedString(string: englishString)
            attributedCaptionString.addAttribute(
                NSFontAttributeName,
                value: UIFont.systemFontOfSize(10.0, weight: weight),
                range: NSMakeRange(0 , attributedCaptionString.length))

            cell.configureCell(attributedTitleString, caption: attributedCaptionString)
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
