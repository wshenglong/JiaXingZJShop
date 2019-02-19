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

//轮播图
struct HomeModel: HandyJSON {
    //var title : String?
    var plat_adv_list : PAdvListModel?
    var goods_hot_list : [GoodHotModel]?
    
}




//首页热门
struct GoodHotModel: HandyJSON {
    var goods_id : String = ""    //商品所属店铺id
    var goods_name : String = ""  //商品名称
    var category_id: Int = 0   //二级分类id
    var category_name : String = "" //二级分类名称
    var promotion_price : String = "" //
    var price : String = ""      //规格最低价
    var promotion_type : String = ""   //
    var market_price : String = "" //市场价
    var pic_cover_small : String = "" //商品图片
    var shop_name : String = "" //店铺名称
    var stock : Int = 0       //当前总数量
    var sku_list: [SkuList]? //SKU规格值列表
    
    //*************************商品模型辅助属性**********************************
    // 记录用户对商品添加次数
    var userBuyNumber: Int = 0
    var number: Int = -1
    
    
}

struct SkuList: HandyJSON {
    var sku_name : String = ""  //规格名称
    var price : String = ""     //价格
    var stock : Int = 0        //当前规格数量
    
}





//焦点模型
struct AdvsinfoModel: HandyJSON {
    //var title : String?
    var adv_id : Int = 0
    var adv_title : String = ""
    var adv_url : String = ""
    var adv_image : String = ""
    
    
}



struct AdvsliatModel: HandyJSON {
    //var title : String?
    var data : [AdvsinfoModel]?
}
