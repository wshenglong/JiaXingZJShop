//
//  UserShopCarTool.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class UserShopCarTool: NSObject {

    fileprivate static let instance = UserShopCarTool()
    
    fileprivate var supermarketProducts = [Goods]()
    
    class var sharedUserShopCar: UserShopCarTool {
        return instance
    }
    
    func userShopCarProductsNumber() -> Int {
        return ShopCarRedDotView.sharedRedDotView.buyNumber
    }
    
    func isEmpty() -> Bool {
        return supermarketProducts.count == 0
    }
    
    func addSupermarkProductToShopCar(_ goods: Goods) {
        for everyGoods in supermarketProducts {
            if everyGoods.id == goods.id {
                return
            }
        }
        
        supermarketProducts.append(goods)
    }
    
    func getShopCarProducts() -> [Goods] {
        return supermarketProducts
    }
    
    func getShopCarProductsClassifNumber() -> Int {
        return supermarketProducts.count
    }
    
    func removeSupermarketProduct(_ goods: Goods) {
        for i in 0..<supermarketProducts.count {
            let everyGoods = supermarketProducts[i]
            if everyGoods.id == goods.id {
                supermarketProducts.remove(at: i)
                NotificationCenter.default.post(name: Notification.Name(rawValue: LFBShopCarDidRemoveProductNSNotification), object: nil, userInfo: nil)
                return
            }
        }
    }
    
    func getAllProductsPrice() -> String {
        var allPrice: Double = 0
        for goods in supermarketProducts {
            allPrice = allPrice + Double(goods.partner_price!)! * Double(goods.userBuyNumber)
        }
        
        return "\(allPrice)".cleanDecimalPointZear()
    }
}
