//
//  OrderUserDetailView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
import UIKit

class OrderUserDetailView: UIView {

    let consigneeLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let consigneeAdressLabel = UILabel()
    let lineView = UIView()
    let shopLabel = UILabel()
    let collectionButton = UIButton()
    
    var order: Order? {
        didSet {
            consigneeLabel.text = "收 货 人:    " + (order?.accept_name)!
            phoneNumberLabel.text = order?.telphone
            consigneeAdressLabel.text = "收货地址:    "  + (order?.address)!
            shopLabel.text = "配送店铺    " + (order?.dealer_name)!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        consigneeLabel.textColor = LFBTextBlackColor
        consigneeLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(consigneeLabel)
        
        consigneeAdressLabel.textColor = LFBTextBlackColor
        consigneeAdressLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(consigneeAdressLabel)
        
        phoneNumberLabel.textColor = LFBTextBlackColor
        phoneNumberLabel.textAlignment = NSTextAlignment.right
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(phoneNumberLabel)
        
        lineView.backgroundColor = UIColor.lightGray
        lineView.alpha = 0.1
        addSubview(lineView)
        
        shopLabel.textColor = LFBTextBlackColor
        shopLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(shopLabel)
        
        collectionButton.setTitle("+ 收藏", for: UIControl.State())
        collectionButton.setTitleColor(LFBTextBlackColor, for: UIControl.State())
        collectionButton.setTitle("取消收藏", for: .selected)
        collectionButton.setTitleColor(UIColor.white, for: .selected)
        collectionButton.setBackgroundImage(UIImage.imageWithColor(LFBNavigationYellowColor, size: CGSize(width: 60, height: 25), alpha: 1), for: UIControl.State())
        collectionButton.setBackgroundImage(UIImage.imageWithColor(LFBNavigationYellowColor, size: CGSize(width: 60, height: 25), alpha: 1), for: .selected)
        collectionButton.layer.masksToBounds = true
        collectionButton.layer.cornerRadius = 5
        collectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        addSubview(collectionButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin: CGFloat = 10
        let labelHeight: CGFloat = 30
        consigneeLabel.frame = CGRect(x: leftMargin, y: 5, width: width * 0.5, height: labelHeight)
        phoneNumberLabel.frame = CGRect(x: width - width * 0.4 - 10, y: 5, width: width * 0.4, height: labelHeight)
        consigneeAdressLabel.frame = CGRect(x: leftMargin, y: consigneeLabel.frame.maxY, width: width - 20, height: labelHeight)
        lineView.frame = CGRect(x: leftMargin, y: consigneeAdressLabel.frame.maxY + 5, width: width - leftMargin, height: 1)
        shopLabel.frame = CGRect(x: leftMargin, y: lineView.frame.maxY, width: width * 0.6, height: 40)
        collectionButton.frame = CGRect(x: width - 60 - 10, y: lineView.frame.maxY + (40 - 25) * 0.5, width: 60, height: 25)
    }

}
