//
//  ADViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class ADViewController: UIViewController {
    
    fileprivate lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.frame = ScreenBounds
        return backImageView
        }()
    
    var imageName: String? {
        didSet {
            var placeholderImageName: String?
            switch UIDevice.currentDeviceScreenMeasurement() {
            case 3.5:
                placeholderImageName = "iphone4"
            case 4.0:
                placeholderImageName = "iphone5"
            case 4.7:
                placeholderImageName = "iphone6"
            default:
                placeholderImageName = "iphone6s"
            }
            
            backImageView.sd_setImage(with: URL(string: imageName!), placeholderImage: UIImage(named: placeholderImageName!)) { (image, error, _, _) -> Void in
                if error != nil {
                    //加载广告失败
                    print("加载广告失败")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: ADImageLoadFail), object: nil)
                }
                
                if image != nil {
                    let time = DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: time, execute: { () -> Void in
                        
                        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.fade)
                        
                        let time1 = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                        DispatchQueue.main.asyncAfter(deadline: time1, execute: { () -> Void in
                            NotificationCenter.default.post(name: Notification.Name(rawValue: ADImageLoadSecussed), object: image)
                        })
                        
                    })
                } else {
                    //加载广告失败
                    print("加载广告失败")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: ADImageLoadFail), object: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backImageView)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
    }
}
