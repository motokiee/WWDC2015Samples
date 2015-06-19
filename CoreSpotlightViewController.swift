//
//  CoreSpotlightViewController.swift
//  UIKitSample
//
//  Created by Motoki on 2015/06/18.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class CoreSpotlightViewController: UITableViewController {
    
    lazy var items: NSArray = {
        let filePath = NSBundle.mainBundle().pathForResource("CoreSpotlight", ofType:"plist" )
        let array = NSArray(contentsOfFile: filePath!)
        return array!
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoreSpotlightCell", forIndexPath: indexPath)

        let item = self.items.objectAtIndex(indexPath.row) as! NSDictionary
        
        let title = item.objectForKey("title") as! String
        let description = item.objectForKey("description") as! String
        let imageName = item.objectForKey("imageName") as! String

        cell.textLabel?.text = title
        cell.detailTextLabel?.text = description
        cell.imageView?.image = UIImage(named: imageName)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
        let item = self.items.objectAtIndex(indexPath.row) as! NSDictionary
        let title = item.objectForKey("title") as! String
        let description = item.objectForKey("description") as! String
        let imageName = item.objectForKey("imageName") as! String
        
        // searchable itemのための属性を作成
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeCompositeContent as String)
        attributeSet.title = title
        attributeSet.contentDescription = description
        attributeSet.thumbnailData = NSData(data: UIImagePNGRepresentation(UIImage(named: imageName)!)!)
        attributeSet.keywords = ["trip", "wwdc", "san francisco"]
        
        // searchable itemを作成
        let identifier = "CoreSpotlight" + "-" + title
        let searchableItem = CSSearchableItem(uniqueIdentifier: identifier, domainIdentifier: "motoki.narita", attributeSet: attributeSet)
        searchableItem.expirationDate = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 7)
        
        // indexへ登録
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { (error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                let alert = UIAlertController(title: "added to index", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: {
                    
                })
            }
        }
    }
    
    @IBAction func deleteIndex(sender: AnyObject) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let alert = UIAlertController(title: "indexからアイテムを全削除します", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                CSSearchableIndex.defaultSearchableIndex().deleteAllSearchableItemsWithCompletionHandler({ (error) -> Void in

                })
            }))
            
            alert.addAction(UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
        }
        
    }
}
