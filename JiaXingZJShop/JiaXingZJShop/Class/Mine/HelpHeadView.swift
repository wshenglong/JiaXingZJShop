//
//  HelpHeadView.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class HelpHeadView: UITableViewHeaderFooterView {

    var questionLabel: UILabel?
    var arrowImageView: UIImageView?
    var isSelected: Bool = false {
        willSet {
            if newValue {
                arrowImageView!.image = UIImage(named: "cell_arrow_up_accessory")
            } else {
                arrowImageView!.image = UIImage(named: "cell_arrow_down_accessory")
            }
        }
    }
    let lineView = UIView()
    
    weak var delegate: HelpHeadViewDelegate?
    
    var question: Question? {
        didSet {
            questionLabel?.text = question?.title
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        questionLabel = UILabel()
        questionLabel?.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(questionLabel!)
        
        arrowImageView = UIImageView(image: UIImage(named: "cell_arrow_down_accessory"))
        contentView.addSubview(arrowImageView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(headViewDidClick(_:)))
        contentView.addGestureRecognizer(tap)
        
        lineView.alpha = 0.08
        lineView.backgroundColor = UIColor.black
        contentView.addSubview(lineView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        questionLabel?.frame = CGRect(x: 20, y: 0, width: width - 20, height: height)
        arrowImageView?.frame = CGRect(x: width - 30, y: (height - arrowImageView!.size.height) * 0.5, width: arrowImageView!.size.width, height: arrowImageView!.size.height)
        lineView.frame = CGRect(x: 0, y: 0, width: width, height: 1)
        
    }
    
    @objc func headViewDidClick(_ tap: UITapGestureRecognizer) {
        isSelected = !isSelected
        
        if delegate != nil && delegate!.responds(to: #selector(HelpHeadViewDelegate.headViewDidClck(_:))) {

            delegate!.headViewDidClck!(self)
        }
    }
}

@objc protocol HelpHeadViewDelegate: NSObjectProtocol {
    @objc optional
    func headViewDidClck(_ headView: HelpHeadView)
}
