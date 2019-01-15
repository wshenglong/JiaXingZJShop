//
//  SearchProductsModel.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class SearchProducts: NSObject, DictModelProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Goods]?
    
    class func loadSearchData(_ completion:((_ data: SearchProducts?, _ error: NSError?) -> Void)) {
        let path = Bundle.main.path(forResource: "促销", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: SearchProducts.self) as? SearchProducts
            completion(data, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Goods.self)"]
    }
}
