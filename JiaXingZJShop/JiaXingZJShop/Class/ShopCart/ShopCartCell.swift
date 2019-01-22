//
//  ShopCartCell.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class ShopCartCell: UITableViewCell {

    fileprivate let titleLabel = UILabel()
    fileprivate let priceLabel = UILabel()
    fileprivate let buyView    = BuyView()
    
    var goods: GoodHotModel? {
        didSet {
            if goods?.category_id == 1 {
                titleLabel.text = "[精选]" + goods!.goods_name
            } else {
                titleLabel.text = goods?.goods_name
            }
            
            priceLabel.text = "$" + goods!.price.cleanDecimalPointZear()
            
            buyView.goods = goods
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        titleLabel.frame = CGRect(x: 15, y: 0, width: ScreenWidth * 0.5, height: ShopCartRowHeight)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        
        buyView.frame = CGRect(x: ScreenWidth - 85, y: (ShopCartRowHeight - 25) * 0.55, width: 80, height: 25)
        contentView.addSubview(buyView)
        
        priceLabel.frame = CGRect(x: buyView.frame.minX - 100 - 5, y: 0, width: 100, height: ShopCartRowHeight)
        priceLabel.textAlignment = NSTextAlignment.right
        contentView.addSubview(priceLabel)
        
        let lineView = UIView(frame: CGRect(x: 10, y: ShopCartRowHeight - 0.5, width: ScreenWidth - 10, height: 0.5))
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static fileprivate let identifier = "ShopCarCell"
    
    class func shopCarCell(_ tableView: UITableView) -> ShopCartCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ShopCartCell
        
        if cell == nil {
            cell = ShopCartCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
}
