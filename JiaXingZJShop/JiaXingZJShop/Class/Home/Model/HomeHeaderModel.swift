//
//  HomeHeaderModel.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/17.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import HandyJSON


struct AdvListModel: HandyJSON {
    var adv_id : Int = 0
    var adv_title : String = ""
    var adv_image : String = ""
}


struct PAdvListModel: HandyJSON {
    var ap_id : Int = 0
    var ap_name : String = ""
    var ap_intro : String = ""
    var adv_list : [AdvListModel]?
}


struct HomeHeaderModel: HandyJSON {
    //var title : String?
    var plat_adv_list : PAdvListModel?
}
