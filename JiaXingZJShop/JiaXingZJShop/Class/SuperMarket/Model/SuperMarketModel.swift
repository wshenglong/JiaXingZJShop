//
//  SuperMarketModel.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/16.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import HandyJSON

struct TabModel: HandyJSON {
    var sort : Int = 0
    var category_name : String = ""
    var category_id : Int = 0
}


struct responseModel: HandyJSON {
    //var title : String?
    var data : [TabModel]?
}
