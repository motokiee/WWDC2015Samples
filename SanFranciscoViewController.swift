//
//  SanFranciscoViewController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/21.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit

class SanFranciscoViewController: UITableViewController {

    let fontSize: CGFloat = 50.0
    
    lazy var items: [String] = {
        let filePath = NSBundle.mainBundle().pathForResource("SFFontWeight", ofType:"plist" )
        let list = NSArray(contentsOfFile: filePath!)
        return list as! [String]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 100
        self.title = "SF Font"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SanFranciscoSampleCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい..."
        cell.detailTextLabel?.text = "The quick brown fox jumps over the lazy dog."
        
        var weight: CGFloat

        switch items[indexPath.section] {
        case "UIFontWeightUltraLight":
            weight = UIFontWeightUltraLight
        case "UIFontWeightThin":
            weight = UIFontWeightThin
        case "UIFontWeightLight":
            weight = UIFontWeightLight
        case "UIFontWeightRegular":
            weight = UIFontWeightRegular
        case "UIFontWeightMedium":
            weight = UIFontWeightMedium
        case "UIFontWeightSemibold":
            weight = UIFontWeightSemibold
        case "UIFontWeightBold":
            weight = UIFontWeightBold
        case "UIFontWeightHeavy":
            weight = UIFontWeightHeavy
        case "UIFontWeightBlack":
            weight = UIFontWeightBlack
            
        default:
            weight = UIFontWeightRegular
        }

        cell.textLabel?.font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var weight: CGFloat = UIFontWeightUltraLight
        
        switch items[section] {
        case "UIFontWeightUltraLight":
            weight = UIFontWeightUltraLight
        case "UIFontWeightThin":
            weight = UIFontWeightThin
        case "UIFontWeightLight":
            weight = UIFontWeightLight
        case "UIFontWeightRegular":
            weight = UIFontWeightRegular
        case "UIFontWeightMedium":
            weight = UIFontWeightMedium
        case "UIFontWeightSemibold":
            weight = UIFontWeightSemibold
        case "UIFontWeightBold":
            weight = UIFontWeightBold
        case "UIFontWeightHeavy":
            weight = UIFontWeightHeavy
        case "UIFontWeightBlack":
            weight = UIFontWeightBlack
            
        default:
            weight = UIFontWeightRegular
        }

        let font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
        
        return font.fontName.componentsSeparatedByString("-")[1]
        
    }
}