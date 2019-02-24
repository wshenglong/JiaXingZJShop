//
//  NetworkTools.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ProductsViewController: AnimationViewController {
    
    fileprivate let headViewIdentifier   = "supermarketHeadView"
    fileprivate var lastOffsetY: CGFloat = 0
    fileprivate var isScrollDown         = false
    
    var productsTableView: LFBTableView?
    weak var delegate: ProductsViewControllerDelegate?
    var refreshUpPull:(() -> ())?
    
    //商品模型组
    fileprivate var goodsArr: [[GoodsModelDate]]? {
        didSet {
            productsTableView?.reloadData()
        }
    }
    var goodsCategories : TabModel?
    var goosDate :  [GoodsModelDate]? {
        didSet {
           // print(goosDate)
           // print("*** \n")
            var arr = [[GoodsModelDate]]()
            let arrt = [GoodsModelDate]()
            for singegoods in (goodsCategories?.child_list)! {
                var singegoodsIsLoadFinish = false
                for singgoodsdate in goosDate! {
                    if singgoodsdate.category_id == singegoods.category_id {
                        arr.append([singgoodsdate])
                        singegoodsIsLoadFinish = true
                    }
                    
                }
                if singegoodsIsLoadFinish == false {
                    arr.append(arrt)
                }
               // print(goodsArr)
            }
            self.goodsArr = arr
        }
    }
    
    var supermarketData: Supermarket? {
        didSet {
            let aa = [GoodsModelDate]() //分类资源
            
            //self.goodsArr = Supermarket.searchCategoryMatchProducts(supermarketData?.data ?? aa)
            //self.goodsArr = Supermarket.searchCategoryMatchProducts(supermarketData?.data ?? aa)
        }
    }
    
    var categortsSelectedIndexPath: IndexPath? {
        didSet {
            productsTableView?.selectRow(at: IndexPath(row: 0, section: (categortsSelectedIndexPath! as NSIndexPath).row), animated: true, scrollPosition: .top)
        }
    }
    
    
    // MARK: - Lift Cycle
    // 超市商品分类列表
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarBuyProductNumberDidChange), name: NSNotification.Name(rawValue: LFBShopCarBuyProductNumberDidChangeNotification), object: nil)
        
        // y : 位置
        view = UIView(frame: CGRect(x: ScreenWidth * 0.25, y: 44, width: ScreenWidth * 0.75, height: ScreenHeight - NavigationH))
        buildProductsTableView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Build UI
    fileprivate func buildProductsTableView() {
        productsTableView = LFBTableView(frame: view.bounds, style: .plain)
        productsTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        productsTableView?.backgroundColor = LFBGlobalBackgroundColor
        productsTableView?.delegate = self
        productsTableView?.dataSource = self
        productsTableView?.register(SupermarketHeadView.self, forHeaderFooterViewReuseIdentifier: headViewIdentifier)
        productsTableView?.tableFooterView = buildProductsTableViewTableFooterView()
        
        //let headView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: Selector(("startRefreshUpPull")))
        let headView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: #selector(ProductsViewController.startRefreshUpPull))
        productsTableView?.mj_header = headView
        
        view.addSubview(productsTableView!)
    }
    
    fileprivate func buildProductsTableViewTableFooterView() -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: productsTableView!.width, height: 70))
        imageView.contentMode = UIView.ContentMode.center
        imageView.image = UIImage(named: "v2_common_footer")
        return imageView
    }
    
    // MARK: - 上拉刷新
    @objc func startRefreshUpPull() {
        if refreshUpPull != nil {
            refreshUpPull!()
        }
    }
    
    // MARK: - Action 
    @objc func shopCarBuyProductNumberDidChange() {
        productsTableView?.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //返回某个节中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goodsArr?.count > 0 {
            return goodsArr![section].count  //section.count无限row
        }
        
        return 0
    }
    
    //返回节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return goodsCategories?.child_list?.count ?? 0
    }
    
    //为cell提供数据 ->单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductCell.cellWithTableView(tableView)
        let goods = goodsArr![(indexPath).section][(indexPath).row]
        cell.goods = goods
        
        weak var tmpSelf = self
        cell.addProductClick = { (imageView) -> () in
            tmpSelf?.addProductsAnimation(imageView)
        }
        
        return cell
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    //头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    //节头自定义视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headViewIdentifier) as! SupermarketHeadView
        if goodsCategories?.child_list?.count > 0 && goodsCategories!.child_list![section].category_name != nil {
            headView.titleLabel.text = goodsCategories!.child_list![section].category_name
        }
        
        return headView
    }
    
    //节头消失时触发
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if delegate != nil && delegate!.responds(to: #selector(ProductsViewControllerDelegate.didEndDisplayingHeaderView(_:))) && isScrollDown {
            delegate!.didEndDisplayingHeaderView!(section)
        }
    }
    
    //节头将要显示时触发
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if delegate != nil && delegate!.responds(to: #selector(ProductsViewControllerDelegate.willDisplayHeaderView(_:))) && !isScrollDown {
            delegate!.willDisplayHeaderView!(section)
        }
    }
    
    //响应选择单元格时触发的方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goods = goodsArr![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        //详情页面
        //let productDetailVC = ProductDetailViewController(goods: goods)
        //navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension ProductsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if animationLayers?.count > 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
        }
        
        isScrollDown = lastOffsetY < scrollView.contentOffset.y
        lastOffsetY = scrollView.contentOffset.y
    }
    
}

@objc protocol ProductsViewControllerDelegate: NSObjectProtocol {
    @objc optional func didEndDisplayingHeaderView(_ section: Int)
    @objc optional func willDisplayHeaderView(_ section: Int)
}
