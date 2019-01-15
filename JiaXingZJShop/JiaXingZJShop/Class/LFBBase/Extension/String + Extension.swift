//
//  String + Extension.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

extension String {
    
    /// 清除字符串小数点末尾的0
    func cleanDecimalPointZear() -> String {

        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substring(with: NSMakeRange(offset, 1)) as NSString
            if s.isEqual(to: "0") || s.isEqual(to: ".") {
                offset -= 1
            } else {
                break
            }
        }
        
        return newStr.substring(to: offset + 1)
    }
}
