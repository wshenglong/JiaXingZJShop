//
//  NetworkTools.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
import HandyJSON
import LTScrollView
private let glt_iphoneX = (UIScreen.main.bounds.height >= 812.0)
class SupermarketViewController: SelectedAdressViewController {
    private var SupermarkettabModel = [TabModel]()
    private var titles: [String] = {
        return []
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        for (index, _) in titles.enumerated() {
            let vc = PageContentVC()
            vc.PageContentVCDate = SupermarkettabModel[index]
            vcs.append(vc)
            
        }
        
        
        return vcs
    }()
    private lazy var layout: LTLayout = {[unowned self] in
        let layout = LTLayout()
        layout.sliderWidth = 40
        layout.titleMargin = 40
        //layout.isAverage = true
        //layout.titleViewBgColor =  LFBGlobalBackgroundColor
        layout.titleColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        layout.titleSelectColor = LFBTextBlackColor
        layout.bottomLineColor = LFBNavigationYellowColor
        layout.titleFont = UIFont.systemFont(ofSize: 14)
       

        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private func managerReact() -> CGRect {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let Y: CGFloat = statusBarH + 44
        let H: CGFloat = glt_iphoneX ? (view.bounds.height - Y - 34) : view.bounds.height - Y
        return CGRect(x: 0, y: 0, width: view.bounds.width, height: H)
    }
    private lazy var simpleManager : LTSimpleManager? = {
        let simpleManager = LTSimpleManager(frame: managerReact(), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout)
        /* 设置代理 监听滚动 */
        simpleManager.delegate = self
        return simpleManager
    }()
    
    
    // MARK : Life cycle
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
        showProgressHUD()
        loadSupermarketData()
        automaticallyAdjustsScrollViewInsets = false
        
        
        //view.addSubview(viewControllers)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
    }

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }

    fileprivate func showProgressHUD() {
        ProgressHUDManager.setBackgroundColor(UIColor.colorWithCustom(230, g: 230, b: 230))
        view.backgroundColor = UIColor.white
        if !ProgressHUDManager.isVisible() {
            ProgressHUDManager.showWithStatus("正在加载中")
            //simpleManager?.removeFromSuperview()
             //simpleManager = nil
        }
       
        
    }
    
    
    fileprivate func loadSupermarketData() {
        weak var tmpSelf = self
        
        NetworkTools.requestData(URLString: "http://jc.cdyso.com:8888/index.php/api/goods/goodsclassificationlist", type: .get, finishedCallback: { (result) in
            guard let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: result as? String) else {return}
            self.SupermarkettabModel = responseModel.data!
            for supermodel in self.SupermarkettabModel {
                self.titles.append(supermodel.category_name)
                
            }
            ProgressHUDManager.dismiss()
            self.view.addSubview(self.simpleManager!)
         
        })
   
    }

}

extension SupermarketViewController: LTSimpleScrollViewDelegate {
    
    //MARK: 滚动代理方法
    func glt_scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("offset -> ", scrollView.contentOffset.y)
    }
    
    //MARK: 控制器刷新事件代理方法  刷新事件
//    func glt_refreshScrollView(_ scrollView: UIScrollView, _ index: Int) {
//        //注意这里循环引用问题。
//        scrollView.mj_header = MJRefreshNormalHeader {[weak scrollView] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                //print("对应控制器的刷新自己玩吧，这里就不做处理了🙂-----\(scrollView)")
//                self.simpleManager!.removeFromSuperview()
//                //self.simpleManager = nil
//                self.loadSupermarketData()
//                scrollView?.mj_header.endRefreshing()
//
//            })
//        }
//    }
}
