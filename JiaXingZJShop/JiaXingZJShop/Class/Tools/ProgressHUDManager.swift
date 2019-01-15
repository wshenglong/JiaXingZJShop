//
//  ProgressHUDManager.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit


class ProgressHUDManager {
    
    class func setBackgroundColor(_ color: UIColor) {
        SVProgressHUD.setBackgroundColor(color)
    }
    
    class func setForegroundColor(_ color: UIColor) {
        SVProgressHUD.setForegroundColor(color)
    }
    
    class func setSuccessImage(_ image: UIImage) {
        SVProgressHUD.setSuccessImage(image)
    }
    
    class func setErrorImage(_ image: UIImage) {
        SVProgressHUD.setErrorImage(image)
    }
    
    class func setFont(_ font: UIFont) {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
    }

    class func showImage(_ image: UIImage, status: String) {
        SVProgressHUD.show(image, status: status)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func showWithStatus(_ status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func isVisible() -> Bool {
       return SVProgressHUD.isVisible()
    }
    
    class func showSuccessWithStatus(_ string: String) {
        SVProgressHUD.showSuccess(withStatus: string)
    }
}
