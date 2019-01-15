//
//  MineCell.swift
///  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class MineCell: UITableViewCell {
    
    var mineModel: MineCellModel? {
        didSet {
            titleLabel.text = mineModel!.title
            iconImageView.image = UIImage(named: mineModel!.iconName!)
        }
    }
    
    static fileprivate let identifier = "CellID"
    
    class func cellFor(_ tableView: UITableView) -> MineCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MineCell
        
        if cell == nil {
            cell = MineCell(style: .default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
    let bottomLine = UIView()
    fileprivate lazy var iconImageView = UIImageView()
    fileprivate lazy var titleLabel = UILabel()
    fileprivate lazy var arrowView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconImageView)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.alpha = 0.8
        contentView.addSubview(titleLabel)
        
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.alpha = 0.15
        contentView.addSubview(bottomLine)
        
        arrowView.image = UIImage(named: "icon_go")
        contentView.addSubview(arrowView)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowView.frame = CGRect(x: width - 20, y: (height - (arrowView.image?.size.height)!) * 0.5, width: (arrowView.image?.size.width)!, height: (arrowView.image?.size.height)!)
        
        let rightMargin: CGFloat = 10
        let iconWH: CGFloat = 20
        iconImageView.frame = CGRect(x: rightMargin, y: (height - iconWH) * 0.5, width: iconWH, height: iconWH)
        titleLabel.frame = CGRect(x: iconImageView.frame.maxX + rightMargin, y: 0, width: 200, height: height)
        
        let leftMarge: CGFloat = 20
        bottomLine.frame = CGRect(x: leftMarge, y: height - 0.5, width: width - leftMarge, height: 0.5)
    }
    
}


class MineCellModel: NSObject {
    
    var title: String?
    var iconName: String?
    
    class func loadMineCellModels() -> [MineCellModel] {
        
        var mines = [MineCellModel]()
        let path = Bundle.main.path(forResource: "MinePlist", ofType: "plist")
        let arr = NSArray(contentsOfFile: path!)

        for dic in arr! {
            mines.append(MineCellModel.mineModel(dic as! NSDictionary))
        }
        
        return mines
    }
    
    class func mineModel(_ dic: NSDictionary) -> MineCellModel {
    
        let model = MineCellModel()
        model.title = dic["title"] as? String
        model.iconName = dic["iconName"] as? String
        
        return model
    }
    
}






