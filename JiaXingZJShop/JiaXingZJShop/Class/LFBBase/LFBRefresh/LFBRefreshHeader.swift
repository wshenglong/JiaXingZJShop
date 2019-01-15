//
//  LFBRefreshHeader.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class LFBRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        stateLabel?.isHidden = false
        lastUpdatedTimeLabel?.isHidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], for: MJRefreshState.idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], for: MJRefreshState.pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], for: MJRefreshState.refreshing)
        
        setTitle("下拉刷新", for: .idle)
        setTitle("松手开始刷新", for: .pulling)
        setTitle("正在刷新", for: .refreshing)

    }
}
