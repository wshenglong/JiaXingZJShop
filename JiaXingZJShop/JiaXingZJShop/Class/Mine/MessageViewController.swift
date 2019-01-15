//
//  MessageViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class MessageViewController: BaseViewController {
    
    fileprivate var segment: LFBSegmentedControl!
    fileprivate var systemTableView: LFBTableView!
    fileprivate var systemMessage: [UserMessage]?
    fileprivate var userMessage: [UserMessage]?
    fileprivate var secondView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bulidSystemTableView()
        bulidSecontView()
        bulidSegmentedControl()
        showSystemTableView()
        loadSystemMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func bulidSecontView() {
        secondView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64))
        secondView?.backgroundColor = LFBGlobalBackgroundColor
        view.addSubview(secondView!)
        
        let normalImageView = UIImageView(image: UIImage(named: "v2_my_message_empty"))
        normalImageView.center = view.center
        normalImageView.center.y -= 150
        secondView?.addSubview(normalImageView)
        
        let normalLabel = UILabel()
        normalLabel.text = "~~~并没有消息~~~"
        normalLabel.textAlignment = NSTextAlignment.center
        normalLabel.frame = CGRect(x: 0, y: normalImageView.frame.maxY + 10, width: ScreenWidth, height: 50)
        secondView?.addSubview(normalLabel)
    }

    fileprivate func bulidSegmentedControl() {
        weak var tmpSelf = self
        segment = LFBSegmentedControl(items: ["系统消息" as AnyObject, "用户消息" as AnyObject], didSelectedIndex: { (index) -> () in
            if 0 == index {
                tmpSelf!.showSystemTableView()
            } else if 1 == index {
                tmpSelf!.showUserTableView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRect(x: 0, y: 5, width: 180, height: 27)
    }
    
    fileprivate func bulidSystemTableView() {
        systemTableView = LFBTableView(frame: view.bounds, style: .plain)
        systemTableView.backgroundColor = LFBGlobalBackgroundColor
        systemTableView.showsHorizontalScrollIndicator = false
        systemTableView.showsVerticalScrollIndicator = false
        systemTableView.delegate = self
        systemTableView.dataSource = self
        systemTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.addSubview(systemTableView)

    }

    
    fileprivate func loadSystemMessage() {
        weak var tmpSelf = self
        UserMessage.loadSystemMessage { (data, error) -> () in
            tmpSelf!.systemMessage = data
            tmpSelf!.systemTableView.reloadData()
        }
    }
    
    fileprivate func showSystemTableView() {
        secondView?.isHidden = true
    }
    
    fileprivate func showUserTableView() {
        secondView?.isHidden = false
    }
    
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SystemMessageCell.systemMessageCell(tableView)
        cell.message = systemMessage![(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemMessage?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = systemMessage![(indexPath as NSIndexPath).row]
        
        return message.cellHeight
    }
}
