//
//  Supermarket.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit

class Supermarket: NSObject, DictModelProtocol {
    @objc var code: Int = -1
    @objc var msg: String?
    @objc var reqid: String?
    @objc var data: SupermarketResouce?
    
    class func loadSupermarketData(_ completion:(_ data: Supermarket?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "supermarket", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
//            let modelTool = DictModelManager.sharedManager
//            let data = modelTool.objectWithDictionary(dict, cls: Supermarket.self) as? Supermarket
            let dataModel = Supermarket.mj_object(withKeyValues: dict)
            dataModel?.data?.categories = Categorie.mj_objectArray(withKeyValuesArray: dataModel?.data?.categories) as? [Categorie]
            completion(dataModel, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(SupermarketResouce.self)"]
    }
    
    class func searchCategoryMatchProducts(_ supermarketResouce: SupermarketResouce) -> [[GoodHotModel]]? {
        var arr = [[GoodHotModel]]()
        //通过cate.id获取supermaketPesouce.catepories!
        //根据 cate.id顺序取出所以排序也是一样
        let products = supermarketResouce.products
        for cate in supermarketResouce.categories! {
//           let goodsArr = products!.value(forKey: cate.id!) as! [Goods]
            let goodsArr = Goods.mj_objectArray(withKeyValuesArray: products!.value(forKey: cate.id!)) as! [GoodHotModel]
            arr.append(goodsArr)
        }
//        arr = Goods.mj_objectArray(withKeyValuesArray: products) as! [[Goods]]
        return arr
    }
    
    
}

class SupermarketResouce: NSObject {
    @objc var categories: [Categorie]?
    @objc var products: Products?
    @objc var trackid: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["categories" : "\(Categorie.self)", "products" : "\(Products.self)"]
    }
}

class Categorie: NSObject {
    @objc var id: String?
    @objc var name: String?
    @objc var sort: String?
}

class Products: NSObject, DictModelProtocol {
    @objc var a82: [Goods]?
    @objc var a96: [Goods]?
    @objc var a99: [Goods]?
    @objc var a106: [Goods]?
    @objc var a134: [Goods]?
    @objc var a135: [Goods]?
    @objc var a136: [Goods]?
    @objc var a137: [Goods]?
    @objc var a141: [Goods]?
    @objc var a143: [Goods]?
    @objc var a147: [Goods]?
    @objc var a151: [Goods]?
    @objc var a152: [Goods]?
    @objc var a158: [Goods]?
    
    static func customClassMapping() -> [String : String]? {
        return ["a82" : "\(Goods.self)", "a96" : "\(Goods.self)", "a99" : "\(Goods.self)", "a106" : "\(Goods.self)", "a134" : "\(Goods.self)", "a135" : "\(Goods.self)", "a136" : "\(Goods.self)", "a141" : "\(Goods.self)", "a143" : "\(Goods.self)", "a147" : "\(Goods.self)", "a151" : "\(Goods.self)", "a152" : "\(Goods.self)", "a158" : "\(Goods.self)", "a137" : "\(Goods.self)"]
    }
}

