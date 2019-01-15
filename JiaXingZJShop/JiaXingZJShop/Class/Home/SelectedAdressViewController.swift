//
//  SelectedAdressViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class SelectedAdressViewController: AnimationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UserInfo.sharedUserInfo.hasDefaultAdress() {
            let titleView = AdressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            titleView.setTitle(UserInfo.sharedUserInfo.defaultAdress()!.address!)
            titleView.frame = CGRect(x: 0, y: 0, width: titleView.adressWidth, height: 30)
            navigationItem.titleView = titleView
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(SelectedAdressViewController.titleViewClick))
            navigationItem.titleView?.addGestureRecognizer(tap)
        }
    }
    
    // MARK: - Build UI
    fileprivate func buildNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton("扫一扫", titleColor: UIColor.black,
            image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
            target: self, action: #selector(SelectedAdressViewController.leftItemClick), type: ItemButtonType.left)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("搜 索", titleColor: UIColor.black,
            image: UIImage(named: "icon_search")!,hightLightImage: nil,
            target: self, action: #selector(SelectedAdressViewController.rightItemClick), type: ItemButtonType.right)
        
        let titleView = AdressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        titleView.frame = CGRect(x: 0, y: 0, width: titleView.adressWidth, height: 30)
        navigationItem.titleView = titleView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SelectedAdressViewController.titleViewClick))
        navigationItem.titleView?.addGestureRecognizer(tap)
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    @objc func leftItemClick() {
        let qrCode = QRCodeViewController()
        navigationController?.pushViewController(qrCode, animated: true)
    }
    
    @objc func rightItemClick() {
        let searchVC = SearchProductViewController()
        navigationController!.pushViewController(searchVC, animated: false)
    }
    
    @objc func titleViewClick() {
        weak var tmpSelf = self
        
        let adressVC = MyAdressViewController { (adress) -> () in
            let titleView = AdressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            titleView.setTitle(adress.address!)
            titleView.frame = CGRect(x: 0, y: 0, width: titleView.adressWidth, height: 30)
            tmpSelf?.navigationItem.titleView = titleView
            UserInfo.sharedUserInfo.setDefaultAdress(adress)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(SelectedAdressViewController.titleViewClick))
            tmpSelf?.navigationItem.titleView?.addGestureRecognizer(tap)
        }
        adressVC.isSelectVC = true
        navigationController?.pushViewController(adressVC, animated: true)
    }
}
