//
//  PageContentVC.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/2/19.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
import HandyJSON
class PageContentVC: UIViewController {
    private var tabModel = [Child_list]()
    
    
    
    var PageContentVCDate: TabModel? {
        didSet {
//           print(PageContentVCDate?.child_list)
//           print("---")
//            print(PageContentVCDate!.child_list!)
//            print("\n")
            prodateURLS = baseURLS + (PageContentVCDate?.category_id)!
           
        }
    }
    private let baseURLS : String = "http://jc.cdyso.com:8888/index.php/api/goods/goodslist?category_id="
    private var prodateURLS : String = ""
   // fileprivate var supermarketData: Supermarket?
    fileprivate var categoryTableView: LFBTableView!
    
    
    fileprivate var productsVC: ProductsViewController!
    
    // flag
    fileprivate var categoryTableViewIsLoadFinish = false
    fileprivate var productTableViewIsLoadFinish  = false
    
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        
        showProgressHUD()
        
        bulidCategoryTableView()
        
        bulidProductsViewController()
        
        loadSupermarketData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if productsVC.productsTableView != nil {
            productsVC.productsTableView?.reloadData()
        }

        //        NotificationCenter.default.post(name: Notification.Name(rawValue: "LFBSearchViewControllerDeinit"), object: nil)
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarBuyProductNumberDidChange), name: NSNotification.Name(rawValue: LFBShopCarBuyProductNumberDidChangeNotification), object: nil)
    }
    
    @objc func shopCarBuyProductNumberDidChange() {
        if productsVC.productsTableView != nil {
            productsVC.productsTableView!.reloadData()
        }
    }
    
    // MARK:- Creat UI
    fileprivate func bulidCategoryTableView() {
        //frame:44== 上边距
        categoryTableView = LFBTableView(frame: CGRect(x: 0, y: 44, width: ScreenWidth * 0.25, height: ScreenHeight), style: .plain)
        categoryTableView.backgroundColor = LFBGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        //未实现注册 https://www.jianshu.com/p/d7436f4ea499
        //contentInset https://www.jianshu.com/p/9f9b98faaf5b
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        categoryTableView.isHidden = true;
        view.addSubview(categoryTableView)
     
    }
    
    
    
    
    fileprivate func bulidProductsViewController() {
        productsVC = ProductsViewController()
        productsVC.delegate = self
        productsVC.view.isHidden = true
        addChild(productsVC)
        view.addSubview(productsVC.view)
        
        weak var tmpSelf = self
        
        productsVC.refreshUpPull = {
            NetworkTools.requestData(URLString: self.prodateURLS, type: .get, finishedCallback: { (result) in
                guard let responseModel = JSONDeserializer<GoodsModel>.deserializeFrom(json: result as? String) else {return}
                //self.tabModel = responseModel.data!
                
                //tmpSelf!.productsVC.supermarketData = responseModel.data!
                tmpSelf!.productsVC.goodsCategories = tmpSelf!.PageContentVCDate
                tmpSelf!.productsVC.goosDate = responseModel.data
               
                tmpSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                tmpSelf!.categoryTableView.reloadData()
                tmpSelf!.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            })

        }
    }
    
    fileprivate func loadSupermarketData() {
        
         var testhf = PageContentVCDate
         weak var tmpSelf = self
        tabModel = testhf?.child_list ?? []
            categoryTableView.reloadData()
           tmpSelf!.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            categoryTableViewIsLoadFinish = true
        
        NetworkTools.requestData(URLString: self.prodateURLS, type: .get, finishedCallback: { (result) in
            guard let responseModel = JSONDeserializer<GoodsModel>.deserializeFrom(json: result as? String) else {return}
            //self.tabModel = responseModel.data!
            tmpSelf!.productTableViewIsLoadFinish = true
            //print(responseModel.data!)
            if tmpSelf!.categoryTableViewIsLoadFinish && tmpSelf!.productTableViewIsLoadFinish {
                tmpSelf!.categoryTableView.isHidden = false
                
                tmpSelf!.productsVC.productsTableView!.isHidden = false
                tmpSelf!.productsVC.view.isHidden = false
                tmpSelf!.view.backgroundColor = LFBGlobalBackgroundColor
                ProgressHUDManager.dismiss()
            }
            //tmpSelf!.categoryTableView.reloadData()
            //tmpSelf!.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        })
        
        
        
       
        
        

    }
    
    // MARK: - Private Method
    fileprivate func showProgressHUD() {
        ProgressHUDManager.setBackgroundColor(UIColor.colorWithCustom(230, g: 230, b: 230))
        view.backgroundColor = UIColor.white
        if !ProgressHUDManager.isVisible() {
            ProgressHUDManager.showWithStatus("正在加载中2")
        }
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PageContentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return supermarketData?.data?.categories?.count ?? 0
        return tabModel.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView)
        cell.categorie = tabModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //关系实现
                if productsVC != nil {
                    productsVC.categortsSelectedIndexPath = indexPath
                    
                }
         print(indexPath)
    }
    
}

// MARK: - SupermarketViewController
extension PageContentVC: ProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(_ section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section + 1, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func willDisplayHeaderView(_ section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
}


