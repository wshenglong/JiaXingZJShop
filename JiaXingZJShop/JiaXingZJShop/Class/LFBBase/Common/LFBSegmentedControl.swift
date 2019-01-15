//
//  LFBSegmentedControl.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class LFBSegmentedControl: UISegmentedControl {
    
    var segmentedClick:((_ index: Int) -> Void)?
    
    override init(items: [Any]?) {
        super.init(items: items)
        tintColor = LFBNavigationYellowColor
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: UIControl.State.selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.colorWithCustom(100, g: 100, b: 100)], for: UIControl.State())
        addTarget(self, action: #selector(segmentedControlDidValuechange(_:)), for: UIControl.Event.valueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?, didSelectedIndex: @escaping (_ index: Int) -> ()) {
        self.init(items: items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc func segmentedControlDidValuechange(_ sender: UISegmentedControl) {
        if segmentedClick != nil {
            segmentedClick!(sender.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
