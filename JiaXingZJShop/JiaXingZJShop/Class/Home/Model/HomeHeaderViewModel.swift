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

    
}

extension HomeHeaderViewModel {
    func requestData(finishCallback :  @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://jc.cdyso.com:8888/index.php/api/index", type: .get) { (result) in
            guard let responseModel = JSONDeserializer<HomeHeaderModel>.deserializeFrom(json: result as? String) else {return}
            self.advListModels = responseModel.plat_adv_list?.adv_list ?? []
            for (index, _) in self.advListModels.enumerated() {
                self.advListModels[index].adv_image = baseURLS + self.advListModels[index].adv_image
            }
            
            finishCallback()

        }
        
    }
    
}
