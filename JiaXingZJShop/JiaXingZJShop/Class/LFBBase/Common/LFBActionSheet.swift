//
//  LFBActionSheetManger.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

enum ShareType: Int {
    case weiXinMyFriend = 1
    case weiXinCircleOfFriends = 2
    case sinaWeiBo = 3
    case qqZone = 4
}

class LFBActionSheet: NSObject, UIActionSheetDelegate {
    
    fileprivate var selectedShaerType: ((_ shareType: ShareType) -> ())?
    fileprivate var actionSheet: UIActionSheet?
    
    func showActionSheetViewShowInView(_ inView: UIView, selectedShaerType: @escaping ((_ shareType: ShareType) -> ())) {
        
        actionSheet = UIActionSheet(title: "分享到",
            delegate: self, cancelButtonTitle: "取消",
            destructiveButtonTitle: nil,
            otherButtonTitles: "微信好友", "微信朋友圈", "新浪微博", "QQ空间")
        
        self.selectedShaerType = selectedShaerType
        
        actionSheet?.show(in: inView)
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        print(buttonIndex)
        if selectedShaerType != nil {
            
            switch buttonIndex {

            case ShareType.weiXinMyFriend.rawValue:
                selectedShaerType!(.weiXinMyFriend)
                break
                
            case ShareType.weiXinCircleOfFriends.rawValue:
                selectedShaerType!(.weiXinCircleOfFriends)
                break
                
            case ShareType.sinaWeiBo.rawValue:
                selectedShaerType!(.sinaWeiBo)
                break
                
            case ShareType.qqZone.rawValue:
                selectedShaerType!(.qqZone)
                break
                
            default:
                break
            }
        }
    }
    
}
