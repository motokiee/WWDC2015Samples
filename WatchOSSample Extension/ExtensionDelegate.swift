//
//  ExtensionDelegate.swift
//  WatchOSSample Extension
//
//  Created by Motoki on 2015/06/20.
//  Copyright © 2015年 MotokiNarita. All rights reserved.
//

import WatchKit
import WatchConnectivity

let ComplicationCurrentEntry  = "ComplicationCurrentEntry"
let ComplicationForwardEntry  = "ComplicationForwardEntry"
let ComplicationBackwardEntry = "ComplicationBackwardEntry"
let ComplicationTextData      = "ComplicationTextData"
let ComplicationShortTextData = "ComplicationShortTextData"
let ComplicationImageData     = "ComplicationImageData"

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {

    let session = WCSession.defaultSession()
    
    
    // MARK: WKExtensionDelegate
    func applicationDidFinishLaunching() {
        
        if WCSession.isSupported() {
            self.session.delegate = self
            self.session.activateSession()
        }
    }

    func applicationDidBecomeActive() {
    }

    func applicationWillResignActive() {
    }

    // MARK: WKExtensionDelegate - ReceiveMessage
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        guard let recievedMessage = message["Messagekey"] where recievedMessage is String else {return}
        NSNotificationCenter.defaultCenter().postNotificationName("MessageRecieved", object: recievedMessage)
        
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        guard let recievedMessage = message["Messagekey"] where recievedMessage is String else {return}
        NSNotificationCenter.defaultCenter().postNotificationName("MessageRecieved", object:recievedMessage)
        
        let replyInfo: [String : AnyObject] = ["ReplyInfo": "Apple Watch did receive Message"]
        replyHandler(replyInfo)
        
    }

    // MARK: WKExtensionDelegate - ReceiveMessageData
    func session(session: WCSession, didReceiveMessageData messageData: NSData) {
        NSNotificationCenter.defaultCenter().postNotificationName("MessageDataRecieved", object: messageData)
    }

    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        NSNotificationCenter.defaultCenter().postNotificationName("MessageDataRecieved", object: messageData)
        
        let replyInfo: [String : AnyObject] = ["ReplyInfo": "Apple Watch did receive MessageData"]
        let replyData = NSKeyedArchiver.archivedDataWithRootObject(replyInfo)
        replyHandler(replyData)
    }
    
    
    // MARK: WKExtensionDelegate - ApplicationContext
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        guard let recievedApplicationContext = applicationContext["ApplicationContext"] where recievedApplicationContext is String else {return}
        NSNotificationCenter.defaultCenter().postNotificationName("ApplicationContextRecieved", object:recievedApplicationContext)
    }
    
    // MARK: WKExtensionDelegate - ReceiveUserInfo
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        guard let recievedUserInfo = userInfo["UserInfo"] where recievedUserInfo is String else {return}
        NSNotificationCenter.defaultCenter().postNotificationName("TransferUserInfoRecieved", object: recievedUserInfo)

    }

    // MARK: WKExtensionDelegate - DidFinishFileTransfer
    func session(session: WCSession, didReceiveFile file: WCSessionFile) {
        print(file)
        let data = NSData(contentsOfURL: file.fileURL)
        NSNotificationCenter.defaultCenter().postNotificationName("MessageDataRecieved", object: data)
    }
    
    

    // MARK: Complications
    
    lazy var complicationDummyData:[String:[[String:AnyObject]]] = {

        // 共通の画像
        let imageData:[String:UIImage] = [ComplicationImageData:UIImage(named: "complication_sample")!]
        
        // 未来時間時間に表示するデータ
        let forwardText:[String:String] = [ComplicationTextData:"yidev懇親会"]
        let forwardShortText:[String:String] = [ComplicationShortTextData:"申し込んでない"]
        
        // 現在時間に表示するデータ
        let currentText:[String:String] = [ComplicationTextData:"第20回 yidev"]
        let currentShortText:[String:String] = [ComplicationShortTextData:"iPhone開発者勉強会"]
        
        // 過去時間時間に表示するデータ
        let backwardText:[String:String] = [ComplicationTextData:"yidev資料作成"]
        let backwardShortText:[String:String] = [ComplicationShortTextData:"間に合うのか"]
        
        return [
            ComplicationForwardEntry:[forwardText, forwardShortText, imageData],
            ComplicationCurrentEntry:[currentText, currentShortText, imageData],
            ComplicationBackwardEntry:[backwardText, backwardShortText, imageData]
            ]
        
        }()

}
