//
//  WatchOSSampleListCell.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit

class WatchOSSampleListCell: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var captionLabel: WKInterfaceLabel!
    
    func configureCell(title: String, caption: String) {
        self.titleLabel.setText(title)
        self.captionLabel.setText(caption)
    }
}
