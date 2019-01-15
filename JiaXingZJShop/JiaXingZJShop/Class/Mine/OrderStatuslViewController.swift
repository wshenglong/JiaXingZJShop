//
//  OrderDetailViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
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


class OrderStatuslViewController: BaseViewController {
    
    fileprivate var orderDetailTableView: LFBTableView?
    fileprivate var segment: LFBSegmentedControl!
    fileprivate var orderDetailVC: OrderDetailViewController?
    fileprivate var orderStatuses: [OrderStatus]? {
        didSet {
            orderDetailTableView?.reloadData()
        }
    }
    
    var order: Order? {
        didSet {
            orderStatuses = order?.status_timeline
            
            if order?.detail_buttons?.count > 0 {
                let btnWidth: CGFloat = 80
                let btnHeight: CGFloat = 30
                for i in 0..<order!.detail_buttons!.count {
                    let btn = UIButton(frame: CGRect(x: view.width - (10 + CGFloat(i + 1) * (btnWidth + 10)), y: view.height - 50 - NavigationH + (50 - btnHeight) * 0.5, width: btnWidth, height: btnHeight))
                    btn.setTitle(order!.detail_buttons![i].text, for: UIControl.State())
                    btn.backgroundColor = LFBNavigationYellowColor
                    btn.setTitleColor(UIColor.black, for: UIControl.State())
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    btn.layer.cornerRadius = 5;
                    btn.tag = order!.detail_buttons![i].type
                    btn.addTarget(self, action: #selector(detailButtonClick(_:)), for: UIControl.Event.touchUpInside)
                    view.addSubview(btn)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildOrderDetailTableView()
        
        buildDetailButtonsView()
    }
    
    fileprivate func buildNavigationItem() {
        let rightItem = UIBarButtonItem.barButton("投诉", titleColor: LFBTextBlackColor, target: self, action: #selector(rightItemButtonClick))
        navigationItem.rightBarButtonItem = rightItem
        weak var tmpSelf = self
        segment = LFBSegmentedControl(items: ["订单状态" as AnyObject, "订单详情" as AnyObject], didSelectedIndex: { (index) -> () in
            if index == 0 {
                tmpSelf!.showOrderStatusView()
            } else if index == 1 {
                tmpSelf!.showOrderDetailView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRect(x: 0, y: 5, width: 180, height: 27)
    }
    
    fileprivate func buildOrderDetailTableView() {
        orderDetailTableView = LFBTableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - NavigationH), style: .plain)
        orderDetailTableView?.backgroundColor = UIColor.white
        orderDetailTableView?.delegate = self
        orderDetailTableView?.dataSource = self
        orderDetailTableView?.rowHeight = 80
        view.addSubview(orderDetailTableView!)
    }
    
    fileprivate func buildDetailButtonsView() {
        let bottomView = UIView(frame: CGRect(x: 0, y: view.height - 50 - NavigationH, width: view.width, height: 1))
        bottomView.backgroundColor = UIColor.gray
        bottomView.alpha = 0.1
        view.addSubview(bottomView)
        
        let bottomView1 = UIView(frame: CGRect(x: 0, y: view.height - 49 - NavigationH, width: view.width, height: 49))
        bottomView1.backgroundColor = UIColor.white
        view.addSubview(bottomView1)
    }
    
    // MARK: - Action
    @objc func rightItemButtonClick() {
        
    }
    
    @objc func detailButtonClick(_ sender: UIButton) {
        print("点击了底部按钮 类型是" + "\(sender.tag)")
    }
    
    func showOrderStatusView() {
        weak var tmpSelf = self
        tmpSelf!.orderDetailVC?.view.isHidden = true
        tmpSelf!.orderDetailTableView?.isHidden = false
    }
    
    func showOrderDetailView() {
        weak var tmpSelf = self
        if tmpSelf!.orderDetailVC == nil {
            tmpSelf!.orderDetailVC = OrderDetailViewController()
            tmpSelf!.orderDetailVC?.view.isHidden = false
            tmpSelf!.orderDetailVC?.order = order
            tmpSelf!.addChild(orderDetailVC!)
            tmpSelf!.view.insertSubview(orderDetailVC!.view, at: 0)
        } else {
            tmpSelf!.orderDetailVC?.view.isHidden = false
        }
        tmpSelf!.orderDetailTableView?.isHidden = true
    }
}

extension OrderStatuslViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderStatusCell.orderStatusCell(tableView)
        cell.orderStatus = orderStatuses![(indexPath as NSIndexPath).row]
        
        if (indexPath as NSIndexPath).row == 0 {
            cell.orderStateType = .top
        } else if (indexPath as NSIndexPath).row == orderStatuses!.count - 1 {
            cell.orderStateType = .bottom
        } else {
            cell.orderStateType = .middle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatuses?.count ?? 0
    }
    
}
