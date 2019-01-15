//
//  DiscountPriceView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
import UIKit

class DiscountPriceView: UIView {
    
    fileprivate var marketPriceLabel: UILabel?
    fileprivate var priceLabel: UILabel?
    fileprivate var lineView: UIView?
    fileprivate var hasMarketPrice = false
    
    var priceColor: UIColor? {
        didSet {
            if priceLabel != nil {
                priceLabel!.textColor = priceColor
            }
        }
    }
    var marketPriceColor: UIColor? {
        didSet {
            if marketPriceLabel != nil {
                marketPriceLabel!.textColor = marketPriceColor
                
                if lineView != nil {
                    lineView?.backgroundColor = marketPriceColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        marketPriceLabel = UILabel()
        marketPriceLabel?.textColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        marketPriceLabel?.font = HomeCollectionTextFont
        addSubview(marketPriceLabel!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        
        marketPriceLabel?.addSubview(lineView!)
        
        priceLabel = UILabel()
        priceLabel?.font = HomeCollectionTextFont
        priceLabel!.textColor = UIColor.red
        addSubview(priceLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(price: String?, marketPrice: String?) {
        self.init()
        
        if price != nil && price?.count != 0 {
            priceLabel!.text = "$" + price!.cleanDecimalPointZear()
            priceLabel!.sizeToFit()
        }
        
        if marketPrice != nil && marketPrice?.count  != 0 {
            marketPriceLabel?.text = "$" + marketPrice!.cleanDecimalPointZear()
            hasMarketPrice = true
            marketPriceLabel?.sizeToFit()
        } else {
            hasMarketPrice = false
        }
        
        if marketPrice == price {
            hasMarketPrice = false
        } else {
            hasMarketPrice = true
        }
        
        marketPriceLabel?.isHidden = !hasMarketPrice
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        priceLabel?.frame = CGRect(x: 0, y: 0, width: priceLabel!.width, height: height)
        if hasMarketPrice {
            marketPriceLabel?.frame = CGRect(x: priceLabel!.frame.maxX + 5, y: 0, width: marketPriceLabel!.width, height: height)
            lineView?.frame = CGRect(x: 0, y: marketPriceLabel!.height * 0.5 - 0.5, width: marketPriceLabel!.width, height: 1)
        }
    }
}
