//
//  UserMessage.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

enum UserMessageType: Int {
    case system = 0
    case user = 1
}

class UserMessage: NSObject {
    
    @objc var id: String?
    @objc var type = -1
    @objc var title: String?
    @objc var content: String?
    @objc var link: String?
    @objc var city: String?
    @objc var noticy: String?
    @objc var send_time: String?
    
    // 辅助参数
    var subTitleViewHeightNomarl: CGFloat = 60
    var cellHeight: CGFloat = 60 + 60 + 20
    var subTitleViewHeightSpread: CGFloat = 0
    
    class func loadSystemMessage(_ complete: ((_ data: [UserMessage]?, _ error: NSError?) -> ())) {
        
        complete(loadMessage(.system)!, nil)
    }
    
    class func loadUserMessage(_ complete: ((_ data: [UserMessage]?, _ error: NSError?) -> ())) {
        complete(loadMessage(.user), nil)
    }
    
    fileprivate class func userMessage(_ dict: NSDictionary) -> UserMessage {

        let modelTool = DictModelManager.sharedManager
        let message = modelTool.objectWithDictionary(dict, cls: UserMessage.self) as? UserMessage

        return message!
    }
    
    // HWM ADD
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Coupon.self)"]
    }
    
    fileprivate class func loadMessage(_ type: UserMessageType) -> [UserMessage]? {
        var data: [UserMessage]? = []
        print(((type == .system) ? "SystemMessage" : "UserMessage"))
        let path = Bundle.main.path(forResource: ((type == .system) ? "SystemMessage" : "UserMessage"), ofType: nil)
        let resData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if resData != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: resData!, options: .allowFragments)) as! NSDictionary
            data = UserMessage.mj_objectArray(withKeyValuesArray: dict["data"]) as? [UserMessage]
//            if let array = dict.object(forKey: "data") as? NSArray {
//                for dict in array {
//                    let message = UserMessage.userMessage(dict as! NSDictionary)
//                    data?.append(message)
//                }
//            }
        }
        return data
    }
}
