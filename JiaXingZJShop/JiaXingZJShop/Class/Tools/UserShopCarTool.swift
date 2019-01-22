//
//  UserShopCarTool.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class UserShopCarTool: NSObject {

    fileprivate static let instance = UserShopCarTool()
    
    fileprivate var supermarketProducts = [GoodHotModel]()
    
    class var sharedUserShopCar: UserShopCarTool {
        return instance
    }
    
    func userShopCarProductsNumber() -> Int {
        return ShopCarRedDotView.sharedRedDotView.buyNumber
    }
    
    func isEmpty() -> Bool {
        return supermarketProducts.count == 0
    }
    
    func addSupermarkProductToShopCar(_ goods: GoodHotModel) {
        for everyGoods in supermarketProducts {
            if everyGoods.goods_id == goods.goods_id {
                return
            }
        }
        
        supermarketProducts.append(goods)
    }
    
    func getShopCarProducts() -> [GoodHotModel] {
        return supermarketProducts
    }
    
    func getShopCarProductsClassifNumber() -> Int {
        return supermarketProducts.count
    }
    
    func removeSupermarketProduct(_ goods: GoodHotModel) {
        for i in 0..<supermarketProducts.count {
            let everyGoods = supermarketProducts[i]
            if everyGoods.goods_id == goods.goods_id {
                supermarketProducts.remove(at: i)
                NotificationCenter.default.post(name: Notification.Name(rawValue: LFBShopCarDidRemoveProductNSNotification), object: nil, userInfo: nil)
                return
            }
        }
    }
    
    func getAllProductsPrice() -> String {
        var allPrice: Double = 0
        for goods in supermarketProducts {
            allPrice = allPrice + Double(goods.price)! * Double(goods.userBuyNumber)
        }
        
        return "\(allPrice)".cleanDecimalPointZear()
    }
}
