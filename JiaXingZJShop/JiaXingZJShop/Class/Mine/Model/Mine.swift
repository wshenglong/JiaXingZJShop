//
//  Mine.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class Mine: NSObject , DictModelProtocol{

    @objc var code: Int = -1
    @objc var msg: String?
    @objc var reqid: String?
    @objc var data: MineData?
    
    class func loadMineData(_ completion:(_ data: Mine?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "Mine", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
//            let modelTool = DictModelManager.sharedManager
//            let data = modelTool.objectWithDictionary(dict, cls: Mine.self) as? Mine
            let dataModel = Mine.mj_object(withKeyValues: dict)
            completion(dataModel, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(MineData.self)"]
    }
}

class MineData: NSObject {
    @objc var has_new: Int = -1
    @objc var has_new_user: Int = -1
    @objc var availble_coupon_num = 0
}
