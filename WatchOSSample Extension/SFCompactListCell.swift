//
//  SFCompactListCell.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit

class SFCompactListCell: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var captionLabel: WKInterfaceLabel!
    
    func configureCell(title: NSAttributedString, caption: NSAttributedString) {
        self.titleLabel.setAttributedText(title)
        self.captionLabel.setAttributedText(caption)
    }
}