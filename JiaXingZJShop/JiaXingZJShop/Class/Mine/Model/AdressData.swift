//
//  AdressData.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class AdressData: NSObject, DictModelProtocol {

    @objc var code: Int = -1
    @objc var msg: String?
    @objc var data: [Adress]?
    
    class func loadMyAdressData(_ completion:(_ data: AdressData?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "MyAdress", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
//            let modelTool = DictModelManager.sharedManager
//            let data = modelTool.objectWithDictionary(dict, cls: AdressData.self) as? AdressData
//            completion(data, nil)
            let dataModel = AdressData.mj_object(withKeyValues: dict)
            dataModel?.data = Adress.mj_objectArray(withKeyValuesArray: dataModel?.data) as? [Adress]
            completion(dataModel, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Adress.self)"]
    }
    
}


class Adress: NSObject {
    
    @objc var accept_name: String?
    @objc var telphone: String?
    @objc var province_name: String?
    @objc var city_name: String?
    @objc var address: String?
    @objc var lng: String?
    @objc var lat: String?
    @objc var gender: String?
}
