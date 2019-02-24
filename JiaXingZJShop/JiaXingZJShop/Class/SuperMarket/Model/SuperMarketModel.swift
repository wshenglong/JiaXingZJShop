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
    var category_id : String = ""
    var child_list : [Child_list]?
}

struct Child_list : HandyJSON {
    var category_id : String = ""
    var category_name : String = ""
    var short_name : String = ""
    
}

struct responseModel: HandyJSON {
    //var title : String?
    var data : [TabModel]?
}



struct GoodsModel: HandyJSON {
    //var title : String?
    var data : [GoodsModelDate]?
}

struct GoodsModelDate: HandyJSON {

    var goods_id : String = ""    //商品所属店铺id
    var goods_name : String = ""  //商品名称
    var shop_id : Int = 0
    var category_id: String = ""   //二级分类id
    var category_name : String = "" //二级分类名称
    var promotion_price : String = "" //
    var price : String = ""      //规格最低价
    var promotion_type : String = ""   //
    var market_price : String = "" //市场价
    var pic_cover_small : String = "" //商品图片
    var shop_name : String = "" //店铺名称
    var stock : Int = 0       //当前总数量
    var sku_list: [Sku_list]? //SKU规格值列表
    
    //*************************商品模型辅助属性**********************************
    // 记录用户对商品添加次数
    var userBuyNumber: Int = 0
    var number: Int = -1
    
    
}

struct Sku_list : HandyJSON {
    var sku_id : String = ""
    var sku_name : String = ""
    var market_price : String = ""
    
}
