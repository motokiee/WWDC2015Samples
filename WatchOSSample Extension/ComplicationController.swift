//
//  ComplicationController.swift
//  WatchOSSample Extension
//
//  Created by Motoki on 2015/06/20.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import ClockKit
import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler(CLKComplicationTimeTravelDirections.None)
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let time = NSDate(timeIntervalSinceNow: NSTimeInterval(-60*60*12))
        handler(time)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let time = NSDate(timeIntervalSinceNow: NSTimeInterval(60*60*12))
        handler(time)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(CLKComplicationPrivacyBehavior.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        
        let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
        var data : [[String:AnyObject]] = myDelegate.complicationDummyData[ComplicationCurrentEntry]!

        var entry : CLKComplicationTimelineEntry?
        let now = NSDate()
        
        switch complication.family {
            
        case .ModularSmall:
            
            let longTextDic = data[0] as! [String:String]
            let longText = longTextDic[ComplicationTextData]!

            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            textTemplate.textProvider = CLKSimpleTextProvider(text: longText)
            
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
            handler(entry)
            
        case .ModularLarge:
            let longTextDic = data[0] as! [String:String]
            let shortTextDic = data[1] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let shortText = shortTextDic[ComplicationShortTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateModularLargeStandardBody()
            modularLage.headerTextProvider = CLKSimpleTextProvider(text: longText)
            modularLage.body1TextProvider = CLKSimpleTextProvider(text: shortText)
            modularLage.headerImageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: modularLage)
            handler(entry)

        case .UtilitarianSmall:
            let longTextDic = data[0] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let utilitarianSmallFlat = CLKComplicationTemplateUtilitarianSmallFlat()
            utilitarianSmallFlat.textProvider = CLKSimpleTextProvider(text: longText)
            utilitarianSmallFlat.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: utilitarianSmallFlat)
            handler(entry)
            
        case .UtilitarianLarge:
            let longTextDic = data[0] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let utilitarianLargeFlat = CLKComplicationTemplateUtilitarianLargeFlat()
            utilitarianLargeFlat.textProvider = CLKSimpleTextProvider(text: longText)
            utilitarianLargeFlat.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: utilitarianLargeFlat)
            handler(entry)
            
        case .CircularSmall:
            let imageDic = data[2] as! [String:UIImage]
            
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateCircularSmallSimpleImage()
            modularLage.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: modularLage)
            handler(entry)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler:
        (([CLKComplicationTimelineEntry]?) -> Void)) {
            
        let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
        var data : [[String:AnyObject]] = myDelegate.complicationDummyData[ComplicationBackwardEntry]!
        
        var entry : CLKComplicationTimelineEntry
        let time = NSDate(timeIntervalSinceNow: NSTimeInterval(-60*60))
        
        switch complication.family {
            
        case .ModularSmall:
            
            let longTextDic = data[0] as! [String:String]
            let longText = longTextDic[ComplicationTextData]!
            
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            textTemplate.textProvider = CLKSimpleTextProvider(text: longText)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: textTemplate)
            handler([entry])
            
        case .ModularLarge:
            let longTextDic = data[0] as! [String:String]
            let shortTextDic = data[1] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let shortText = shortTextDic[ComplicationShortTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateModularLargeStandardBody()
            modularLage.headerTextProvider = CLKSimpleTextProvider(text: longText)
            modularLage.body1TextProvider = CLKSimpleTextProvider(text: shortText)
            modularLage.headerImageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: modularLage)
            handler([entry])
            
        case .UtilitarianSmall:
            let longTextDic = data[0] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let utilitarianSmallFlat = CLKComplicationTemplateUtilitarianSmallFlat()
            utilitarianSmallFlat.textProvider = CLKSimpleTextProvider(text: longText)
            utilitarianSmallFlat.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: utilitarianSmallFlat)
            handler([entry])
            
        case .UtilitarianLarge:
            let longTextDic = data[0] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateUtilitarianLargeFlat()
            modularLage.textProvider = CLKSimpleTextProvider(text: longText)
            modularLage.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: modularLage)
            handler([entry])
            
        case .CircularSmall:
            let imageDic = data[2] as! [String:UIImage]
            
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateCircularSmallSimpleImage()
            modularLage.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: modularLage)
            handler([entry])
            }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        
        let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
        var data : [[String:AnyObject]] = myDelegate.complicationDummyData[ComplicationForwardEntry]!
        
        var entry : CLKComplicationTimelineEntry
        let time = NSDate(timeIntervalSinceNow: NSTimeInterval(60*60))
        
        switch complication.family {
            
        case .ModularSmall:
            
            let longTextDic = data[0] as! [String:String]
            let longText = longTextDic[ComplicationTextData]!
            
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            textTemplate.textProvider = CLKSimpleTextProvider(text: longText)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: textTemplate)
            handler([entry])
            
        case .ModularLarge:
            let longTextDic = data[0] as! [String:String]
            let shortTextDic = data[1] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let shortText = shortTextDic[ComplicationShortTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateModularLargeStandardBody()
            modularLage.headerTextProvider = CLKSimpleTextProvider(text: longText)
            modularLage.body1TextProvider = CLKSimpleTextProvider(text: shortText)
            modularLage.headerImageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: modularLage)
            handler([entry])
            
        case .UtilitarianSmall:
            let longTextDic = data[0] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let utilitarianSmallFlat = CLKComplicationTemplateUtilitarianSmallFlat()
            utilitarianSmallFlat.textProvider = CLKSimpleTextProvider(text: longText)
            utilitarianSmallFlat.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: utilitarianSmallFlat)
            handler([entry])
            
        case .UtilitarianLarge:
            let longTextDic = data[0] as! [String:String]
            let imageDic = data[2] as! [String:UIImage]
            
            let longText = longTextDic[ComplicationTextData]!
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateUtilitarianLargeFlat()
            modularLage.textProvider = CLKSimpleTextProvider(text: longText)
            modularLage.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: modularLage)
            handler([entry])
            
        case .CircularSmall:
            let imageDic = data[2] as! [String:UIImage]
            
            let imageData = imageDic[ComplicationImageData]!
            
            let modularLage = CLKComplicationTemplateCircularSmallSimpleImage()
            modularLage.imageProvider = CLKImageProvider(onePieceImage: imageData)
            
            entry = CLKComplicationTimelineEntry(date: time, complicationTemplate: modularLage)
            handler([entry])
        }
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        
        let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
        var data : [[String:AnyObject]] = myDelegate.complicationDummyData[ComplicationForwardEntry]!
        let imageDic = data[2] as! [String:UIImage]
        
        let longText = "サンプル"
        let shortText = longText
        let imageData = imageDic[ComplicationImageData]!
        
        switch complication.family {
            
        case .ModularSmall:
            
            let modularSmall = CLKComplicationTemplateModularSmallSimpleText()
            modularSmall.textProvider = CLKSimpleTextProvider(text: longText)
            handler(modularSmall)
            
        case .ModularLarge:
            
            let modularLage = CLKComplicationTemplateModularLargeStandardBody()
            modularLage.headerTextProvider = CLKSimpleTextProvider(text: longText)
            modularLage.body1TextProvider = CLKSimpleTextProvider(text: shortText)
            modularLage.headerImageProvider = CLKImageProvider(onePieceImage: imageData)
            handler(modularLage)
            
        case .UtilitarianSmall:
            
            let utilitarianSmallFlat = CLKComplicationTemplateUtilitarianSmallFlat()
            utilitarianSmallFlat.textProvider = CLKSimpleTextProvider(text: longText)
            utilitarianSmallFlat.imageProvider = CLKImageProvider(onePieceImage: imageData)
            handler(utilitarianSmallFlat)
            
        case .UtilitarianLarge:
            
            let utilitarianLarge = CLKComplicationTemplateUtilitarianLargeFlat()
            utilitarianLarge.textProvider = CLKSimpleTextProvider(text: longText)
            utilitarianLarge.imageProvider = CLKImageProvider(onePieceImage: imageData)
            handler(utilitarianLarge)
            
        case .CircularSmall:
            
            let circularSmall = CLKComplicationTemplateCircularSmallSimpleImage()
            circularSmall.imageProvider = CLKImageProvider(onePieceImage: imageData)
            handler(circularSmall)
        }
    }
}
