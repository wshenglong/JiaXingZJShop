//
//  HomeHeaderViewModel.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/17.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
import HandyJSON
private let baseURLS : String = "http://jc.cdyso.com:8888/"

class HomeHeaderViewModel {
    //MARK: - 懒加载属性
    // 0 1 放入数据
    lazy var advListModels : [AdvListModel] = [AdvListModel]()
    
    //获取焦点按钮数据
    lazy var advsinfoModel : [AdvsinfoModel] = [AdvsinfoModel]()
    
    lazy var goods_hot_list : [GoodHotModel] = [GoodHotModel]()
    
    
}

extension HomeHeaderViewModel {
    func requestData(finishCallback :  @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://jc.cdyso.com:8888/index.php/api/index", type: .get) { (result) in
            guard let responseModel = JSONDeserializer<HomeModel>.deserializeFrom(json: result as? String) else {return}
            self.advListModels = responseModel.plat_adv_list?.adv_list ?? []
           
            
            for (index, _) in self.advListModels.enumerated() {
                //拼接完整的url图片数据
                self.advListModels[index].adv_image = baseURLS + self.advListModels[index].adv_image
            }
             self.goods_hot_list = responseModel.goods_hot_list ?? []
            for (index, _) in self.goods_hot_list.enumerated() {
                //拼接完整的url图片数据
                self.goods_hot_list[index].pic_cover_small = baseURLS + self.goods_hot_list[index].pic_cover_small
                print(self.goods_hot_list[index].pic_cover_small)
            }
            
            
            
            finishCallback()

        }
        
    }
    
    //请求首页焦点按钮
    func requestAdvsliatData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://jc.cdyso.com:8888/api/index/advsinfo?ap_id=1152", type: .get) { (result) in
            guard let responseModel = JSONDeserializer<AdvsliatModel>.deserializeFrom(json: result as? String) else {return}
            self.advsinfoModel = responseModel.data ?? []
            for (index, _) in self.advsinfoModel.enumerated() {
                //拼接完整的url图片数据
                self.advsinfoModel[index].adv_image = baseURLS + self.advsinfoModel[index].adv_image
                
            }
            
            finishCallback()
            
        }
    }
    
    //MARK: -异步执行结果排序
    
    
    
}
