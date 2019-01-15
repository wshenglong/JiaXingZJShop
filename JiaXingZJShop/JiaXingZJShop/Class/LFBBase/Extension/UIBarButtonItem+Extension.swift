//
//  UIBarButtonItem+Extension.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

enum ItemButtonType: Int {
    case left = 0
    case right = 1
}

extension UIBarButtonItem {

    class func barButton(_ title: String, titleColor: UIColor, image: UIImage, hightLightImage: UIImage?, target: AnyObject?, action: Selector, type: ItemButtonType) -> UIBarButtonItem {
        var btn:UIButton = UIButton()
        if type == ItemButtonType.left {
            btn = ItemLeftButton(type: .custom)
        } else {
            btn = ItemRightButton(type: .custom)
        }
        btn.setTitle(title, for: UIControl.State())
        btn.setImage(image, for: UIControl.State())
        btn.setTitleColor(titleColor, for: UIControl.State())
        btn.setImage(hightLightImage, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        return UIBarButtonItem(customView: btn)
    }
    
    class func barButton(_ image: UIImage, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = ItemLeftImageButton(type: .custom)
        btn.setImage(image, for: UIControl.State())
        btn.imageView?.contentMode = UIView.ContentMode.center
        btn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        return UIBarButtonItem(customView: btn)
    }
    
    class func barButton(_ title: String, titleColor: UIColor, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        btn.setTitle(title, for: UIControl.State())
        btn.setTitleColor(titleColor, for: UIControl.State())
        btn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if title.count == 2 {
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
        }
        return UIBarButtonItem(customView: btn)
    }

}
