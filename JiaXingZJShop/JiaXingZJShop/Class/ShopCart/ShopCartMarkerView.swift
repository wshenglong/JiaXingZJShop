//
//  ShopCartMarkerView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class ShopCartMarkerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let marketHeight: CGFloat = 60
        
        
        backgroundColor = UIColor.white
        
        
        addSubview(lineView(CGRect(x: 0, y: 0, width: ScreenWidth, height: 0.5)))
        
        let rocketImageView = UIImageView(image: UIImage(named: "icon_lighting"))
        rocketImageView.frame = CGRect(x: 15, y: 5, width: 20, height: 20)
        addSubview(rocketImageView)
        
        let redDotImaegView = UIImageView(image: UIImage(named: "reddot"))
        redDotImaegView.frame = CGRect(x: 15, y: (marketHeight - rocketImageView.frame.maxY - 4) * 0.5 + rocketImageView.frame.maxY, width: 4, height: 4)
        addSubview(redDotImaegView)
        
        let marketTitleLabel = UILabel(frame: CGRect(x: rocketImageView.frame.maxX + 10, y: 5, width: ScreenWidth * 0.6, height: 20))
        marketTitleLabel.text = "闪电超市"
        marketTitleLabel.font = UIFont.systemFont(ofSize: 12)
        marketTitleLabel.textColor = UIColor.lightGray
        addSubview(marketTitleLabel)
        
        let marketLabel = UILabel(frame: CGRect(x: redDotImaegView.frame.maxX + 5, y: rocketImageView.frame.maxY, width: ScreenWidth * 0.7, height: 60 - rocketImageView.frame.maxY))
        marketLabel.text = "   22:00前满$30免运费,22:00后满$50面运费"
        marketLabel.textColor = UIColor.lightGray
        marketLabel.font = UIFont.systemFont(ofSize: 10)
        addSubview(marketLabel)
        
        addSubview(lineView(CGRect(x: 0, y: marketHeight - 0.5, width: ScreenWidth, height: 0.5)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func lineView(_ frame: CGRect) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        return lineView
    }
    
}
