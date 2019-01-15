//
//  UserInfo.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//  当前用户信息

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class UserInfo: NSObject {
    
    fileprivate static let instance = UserInfo()
    
    fileprivate var allAdress: [Adress]?
    
    class var sharedUserInfo: UserInfo {
        return instance
    }
    
    func hasDefaultAdress() -> Bool {
        
        if allAdress != nil {
            return true
        } else {
            return false
        }
    }
    
    func setAllAdress(_ adresses: [Adress]) {
        allAdress = adresses
    }
    
    func cleanAllAdress() {
        allAdress = nil
    }
    
    func defaultAdress() -> Adress? {
        if allAdress == nil {
            weak var tmpSelf = self
            
            AdressData.loadMyAdressData { (data, error) -> Void in
                if data?.data?.count > 0 {
                    tmpSelf!.allAdress = data!.data!
                } else {
                    tmpSelf?.allAdress?.removeAll()
                }
            }
            
            return allAdress?.count > 1 ? allAdress![0] : nil
        } else {
            return allAdress![0]
        }
    }
    
    func setDefaultAdress(_ adress: Adress) {
        if allAdress != nil {
            allAdress?.insert(adress, at: 0)
        } else {
            allAdress = [Adress]()
            allAdress?.append(adress)
        }
    }
}
