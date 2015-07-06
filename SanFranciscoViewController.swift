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
//        cell.textLabel?.text = "美しい国、ジャパン。"
        cell.detailTextLabel?.text = "The quick brown fox jumps over the lazy dog."
        
        var weight: CGFloat = UIFontWeightUltraLight
        
        defer {
            cell.textLabel?.font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
        }
        
        if items[indexPath.section] == "UIFontWeightUltraLight" {
            weight = UIFontWeightUltraLight
        } else if items[indexPath.section] == "UIFontWeightThin" {
            weight = UIFontWeightThin
        } else if items[indexPath.section] == "UIFontWeightLight" {
            weight = UIFontWeightLight
        } else if items[indexPath.section] == "UIFontWeightRegular" {
            weight = UIFontWeightRegular
        } else if items[indexPath.section] == "UIFontWeightMedium" {
            weight = UIFontWeightMedium
        } else if items[indexPath.section] == "UIFontWeightSemibold" {
            weight = UIFontWeightSemibold
        } else if items[indexPath.section] == "UIFontWeightBold" {
            weight = UIFontWeightBold
        } else if items[indexPath.section] == "UIFontWeightHeavy" {
            weight = UIFontWeightHeavy
        } else if items[indexPath.section] == "UIFontWeightBlack" {
            weight = UIFontWeightBlack
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var weight: CGFloat = UIFontWeightUltraLight
        
        if items[section] == "UIFontWeightUltraLight" {
            weight = UIFontWeightUltraLight
        } else if items[section] == "UIFontWeightThin" {
            weight = UIFontWeightThin
        } else if items[section] == "UIFontWeightLight" {
            weight = UIFontWeightLight
        } else if items[section] == "UIFontWeightRegular" {
            weight = UIFontWeightRegular
        } else if items[section] == "UIFontWeightMedium" {
            weight = UIFontWeightMedium
        } else if items[section] == "UIFontWeightSemibold" {
            weight = UIFontWeightSemibold
        } else if items[section] == "UIFontWeightBold" {
            weight = UIFontWeightBold
        } else if items[section] == "UIFontWeightHeavy" {
            weight = UIFontWeightHeavy
        } else if items[section] == "UIFontWeightBlack" {
            weight = UIFontWeightBlack
        }
        
        let font = UIFont.systemFontOfSize(self.fontSize, weight: weight)
        
        print("List:\(items[section])")
        print("Name:\(font.fontName)\n")
        
        return font.fontName
    }
}