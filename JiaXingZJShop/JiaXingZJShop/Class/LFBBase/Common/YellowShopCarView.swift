//
//  YellowShopCarView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class YellowShopCarView: UIView {

    fileprivate var shopViewClick:(() -> ())?
    fileprivate let yellowImageView = UIImageView()
    fileprivate let redDot = ShopCarRedDotView.sharedRedDotView
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: 61, height: 61))
        
        clipsToBounds = false
        
        yellowImageView.image = UIImage(named: "v2_shopNoBorder")
        yellowImageView.frame = CGRect(x: 0, y: 0, width: 61, height: 61)
        addSubview(yellowImageView)
        
        let shopCarImageView = UIImageView(image: UIImage(named: "v2_whiteShopBig"))
        shopCarImageView.frame = CGRect(x: (61 - 45) * 0.5, y: (61 - 45) * 0.5, width: 45, height: 45)
        addSubview(shopCarImageView)
        
        redDot.frame = CGRect(x: frame.size.width - 20, y: 0, width: 20, height: 20)
        addSubview(redDot)
        
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, shopViewClick:@escaping (() -> ())) {
        self.init(frame: frame)

        let tap = UITapGestureRecognizer(target: self, action: #selector(YellowShopCarView.shopViewShowShopCar))
        addGestureRecognizer(tap)
        
        self.shopViewClick = shopViewClick
    }
    
    @objc func shopViewShowShopCar() {
        if shopViewClick != nil {
            shopViewClick!()
        }
    }
}
