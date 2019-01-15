//
//  OrderViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class OrderViewController: BaseViewController {

    var orderTableView: LFBTableView!
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "我的订单"
        
        bulidOrderTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func bulidOrderTableView() {
        orderTableView = LFBTableView(frame: view.bounds, style: UITableView.Style.plain)
        orderTableView.backgroundColor = view.backgroundColor
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.backgroundColor = UIColor.clear
        orderTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.addSubview(orderTableView)
        
        loadOderData()
    }
    
    fileprivate func loadOderData() {
        weak var tmpSelf = self
        OrderData.loadOrderData { (data, error) -> Void in
            tmpSelf!.orders = data?.data
            tmpSelf!.orderTableView.reloadData()
        }
    }

}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource, MyOrderCellDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyOrderCell.myOrderCell(tableView, indexPath: indexPath)
        cell.order = orders![(indexPath as NSIndexPath).row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func orderCellButtonDidClick(_ indexPath: IndexPath, buttonType: Int) {
        print(buttonType, (indexPath as NSIndexPath).row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailVC = OrderStatuslViewController()
        orderDetailVC.order = orders![(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}
