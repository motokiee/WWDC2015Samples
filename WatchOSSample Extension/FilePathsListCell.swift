//
//  FilePathsListCell.swift
//  UIKitSample
//
//  Created by Motoki on 2015/07/03.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit

class FilePathsListCell: NSObject {
    @IBOutlet var captionLabel: WKInterfaceLabel!
    
    func configureCell(caption: String) {
        self.captionLabel.setText(caption)
    }
}
