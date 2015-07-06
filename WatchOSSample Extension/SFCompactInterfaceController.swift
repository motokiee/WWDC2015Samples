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

    var fontSize: CGFloat = 15.0
    @IBOutlet var picker: WKInterfacePicker!
    
    @IBOutlet var table: WKInterfaceTable!
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("SFCompactFontWeight", ofType:"plist" )
        let list = NSArray(contentsOfFile: filePath!)
        return list!
        }()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Font Sizeを動的に変更するためのpicker
        var pickerItems: [WKPickerItem] = [WKPickerItem]()
        for i in 15...80 {
            let item = WKPickerItem()
            item.title = String(i)
            item.caption = "Font Size"
            pickerItems.append(item)
        }
        self.picker.setItems(pickerItems)
        
    }

    override func willActivate() {
        super.willActivate()
        
        // テーブル更新
        self.setupTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func picked(value: Int) {
        
        self.fontSize = CGFloat(value)
        
        // テーブル更新
        self.setupTable()
    }
    
    private func setupTable() {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.table.setNumberOfRows(self.items.count, withRowType: "SFCompactListCell")
            self.items.enumerateObjectsUsingBlock { (object: AnyObject!, index: NSInteger, stop: UnsafeMutablePointer<ObjCBool> ) -> Void in
                
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
                
                
                let font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
                print("Family Name:%@", font.familyName)
                print("Font Name:%@", font.fontName)
                
                let japaneseString = "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい..."
                let attributedTitleString = NSMutableAttributedString(string: japaneseString)
                attributedTitleString.addAttribute(
                    NSFontAttributeName,
                    value: font,
                    range: NSMakeRange(0 , attributedTitleString.length))
                
                let englishString = "The quick brown fox jumps over the lazy dog."
                let attributedCaptionString = NSMutableAttributedString(string: englishString)
                attributedCaptionString.addAttribute(
                    NSFontAttributeName,
                    value: font,
                    range: NSMakeRange(0 , attributedCaptionString.length))
                
                cell.configureCell(attributedTitleString, caption: attributedCaptionString)
            }
        }
    
    }
}
