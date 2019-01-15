//
//  MainAD.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class MainAD: NSObject, DictModelProtocol {
    var code: NSNumber = -1
    @objc var msg: String?
    @objc var data: AD?
    
    class func loadADData(_ completion:(_ data: MainAD?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "AD", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
            let dataModelMainAD = MainAD.mj_object(withKeyValues: dict) as MainAD
//            let modelTool = DictModelManager.sharedManager
//            let data = modelTool.objectWithDictionary(dict, cls: MainAD.self) as? MainAD
            completion(dataModelMainAD, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(AD.self)"]
    }
}

class AD: NSObject {
    @objc var title: String?
    @objc var img_name: String?
    @objc var starttime: String?
    @objc var endtime: String?
}
