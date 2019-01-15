//
//  LoadProgressAnimationView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class LoadProgressAnimationView: UIView {
    
    var viewWidth: CGFloat = 0
    override var frame: CGRect {
        willSet {
            if frame.size.width == viewWidth {
                self.isHidden = true
            }
            super.frame = frame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewWidth = frame.size.width
        backgroundColor = LFBNavigationYellowColor
        self.frame.size.width = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadProgressAnimation() {
        self.frame.size.width = 0
        isHidden = false
        weak var tmpSelf = self
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            tmpSelf?.frame.size.width = tmpSelf?.viewWidth ?? ScreenWidth * 0.6
            
            }, completion: { (finish) -> Void in
                
                let time = DispatchTime.now() + Double(Int64(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time, execute: { () -> Void in
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        tmpSelf?.frame.size.width = tmpSelf?.viewWidth ?? ScreenWidth * 0.8
                    })
                })
        }) 
        
    }
    
    func endLoadProgressAnimation() {
        weak var tmpSelf = self
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            tmpSelf?.frame.size.width = tmpSelf?.viewWidth ?? ScreenWidth
            }, completion: { (finish) -> Void in
                tmpSelf?.isHidden = true
        }) 
    }
}
