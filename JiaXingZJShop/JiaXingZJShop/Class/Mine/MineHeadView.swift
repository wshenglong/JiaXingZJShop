//
//  MineHeadView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class MineHeadView: UIImageView {
    
    let setUpBtn: UIButton = UIButton(type: .custom)
    let iconView: IconView = IconView()
    var buttonClick:(() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "v2_my_avatar_bg")
        setUpBtn.setImage(UIImage(named: "v2_my_settings_icon"), for: UIControl.State())
        setUpBtn.addTarget(self, action: #selector(setUpButtonClick), for: .touchUpInside)
        addSubview(setUpBtn)
        addSubview(iconView)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(frame: CGRect, settingButtonClick:@escaping (() -> Void)) {
        self.init(frame: frame)
        buttonClick = settingButtonClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconViewWH: CGFloat = 150
        iconView.frame = CGRect(x: (width - 150) * 0.5, y: 30, width: iconViewWH, height: iconViewWH)
        
        setUpBtn.frame = CGRect(x: width - 50, y: 10, width: 50, height: 50)
    }
    
    @objc func setUpButtonClick() {
        buttonClick?()
    }
}


class IconView: UIView {
    
    var iconImageView: UIImageView!
    var phoneNum: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView(image: UIImage(named: "v2_my_avatar"))
        addSubview(iconImageView)
        
        phoneNum = UILabel()
        phoneNum.text = "18612348765"
        phoneNum.font = UIFont.boldSystemFont(ofSize: 18)
        phoneNum.textColor = UIColor.white
        phoneNum.textAlignment = .center
        addSubview(phoneNum)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: (width - iconImageView.size.width) * 0.5, y: 0, width: iconImageView.size.width, height: iconImageView.size.height)
        phoneNum.frame = CGRect(x: 0, y: iconImageView.frame.maxY + 5, width: width, height: 30)
    }
}
