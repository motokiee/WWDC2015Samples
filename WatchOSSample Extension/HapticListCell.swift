//
//  HapticListCell.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit

class HapticListCell: NSObject {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    func configureCell(title: String) {
        self.titleLabel.setText(title)
    }
}
