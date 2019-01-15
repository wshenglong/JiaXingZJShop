//
//  BaseNavigationController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class BaseNavigationController: UINavigationController {
    
    var isAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer!.delegate = nil
    }
    
    lazy var backBtn: UIButton = {
        //设置返回按钮属性
        let backBtn = UIButton(type: UIButton.ButtonType.custom)
        backBtn.setImage(UIImage(named: "v2_goback"), for: UIControl.State())
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        
        return backBtn
        }()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        if children.count > 0 {

            UINavigationBar.appearance().backItem?.hidesBackButton = false

            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backBtnClick() {
        popViewController(animated: isAnimation)
    }
    
}
