//
//  MyAdressViewController.swift
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


class MyAdressViewController: BaseViewController {
    
    fileprivate var addAdressButton: UIButton?
    fileprivate var nullImageView = UIView()
    
    var selectedAdressCallback:((_ adress: Adress) -> ())?
    var isSelectVC = false
    var adressTableView: LFBTableView?
    var adresses: [Adress]? {
        didSet {
            if adresses?.count == 0 {
                nullImageView.isHidden = false
                adressTableView?.isHidden = true
            } else {
                nullImageView.isHidden = true
                adressTableView?.isHidden = false
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(selectedAdress: @escaping ((_ adress:Adress) -> ())) {
        self.init(nibName: nil, bundle: nil)
        selectedAdressCallback = selectedAdress
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()

        buildAdressTableView()

        buildNullImageView()

        loadAdressData()

        buildBottomAddAdressButtom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    fileprivate func buildNavigationItem() {
        navigationItem.title = "我的收获地址"
    }
    
    fileprivate func buildAdressTableView() {
        adressTableView = LFBTableView(frame: view.bounds, style: UITableView.Style.plain)
        adressTableView?.frame.origin.y += 10;
        adressTableView?.backgroundColor = UIColor.clear
        adressTableView?.rowHeight = 80
        adressTableView?.delegate = self
        adressTableView?.dataSource = self
        view.addSubview(adressTableView!)
    }
    
    fileprivate func buildNullImageView() {
        nullImageView.backgroundColor = UIColor.clear
        nullImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        nullImageView.center = view.center
        nullImageView.center.y -= 100
        view.addSubview(nullImageView)
        
        let imageView = UIImageView(image: UIImage(named: "v2_address_empty"))
        imageView.center.x = 100
        imageView.center.y = 100
        nullImageView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 10, width: 200, height: 20))
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "你还没有地址哦~"
        nullImageView.addSubview(label)
    }
    
    fileprivate func loadAdressData() {
        weak var tmpSelf = self
        AdressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
                if data?.data?.count > 0 {
                    tmpSelf!.adresses = data!.data
                    tmpSelf!.adressTableView?.isHidden = false
                    tmpSelf!.adressTableView?.reloadData()
                    tmpSelf!.nullImageView.isHidden = true
                    UserInfo.sharedUserInfo.setAllAdress(data!.data!)
                } else {
                    tmpSelf!.adressTableView?.isHidden = true
                    tmpSelf!.nullImageView.isHidden = false
                    UserInfo.sharedUserInfo.cleanAllAdress()
                }
            }
        }
    }
        
    fileprivate func buildBottomAddAdressButtom() {
        let bottomView = UIView(frame: CGRect(x: 0, y: ScreenHeight - 60 - 64, width: ScreenWidth, height: 60))
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
    
        addAdressButton = UIButton(frame: CGRect(x: ScreenWidth * 0.15, y: 12, width: ScreenWidth * 0.7, height: 60 - 12 * 2))
        addAdressButton?.backgroundColor = LFBNavigationYellowColor
        addAdressButton?.setTitle("+ 新增地址", for: UIControl.State())
        addAdressButton?.setTitleColor(UIColor.black, for: UIControl.State())
        addAdressButton?.layer.masksToBounds = true
        addAdressButton?.layer.cornerRadius = 8
        addAdressButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addAdressButton?.addTarget(self, action: #selector(addAdressButtonClick), for: UIControl.Event.touchUpInside)
        bottomView.addSubview(addAdressButton!)
    }
    
    // MARK: - Action
    @objc func addAdressButtonClick() {
        let editVC = EditAdressViewController()
        editVC.topVC = self
        editVC.vcType = EditAdressViewControllerType.add
        navigationController?.pushViewController(editVC, animated: true)
    }
}


extension MyAdressViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return adresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        weak var tmpSelf = self
        let cell = AdressCell.adressCell(tableView, indexPath: indexPath) { (cellIndexPathRow) -> Void in
            let editAdressVC = EditAdressViewController()
            editAdressVC.topVC = tmpSelf
            editAdressVC.vcType = EditAdressViewControllerType.edit
            editAdressVC.currentAdressRow = (indexPath as NSIndexPath).row
            tmpSelf!.navigationController?.pushViewController(editAdressVC, animated: true)
        }
        cell.adress = adresses![(indexPath as NSIndexPath).row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectVC {
            if selectedAdressCallback != nil {
                selectedAdressCallback!(adresses![(indexPath as NSIndexPath).row])
                navigationController?.popViewController(animated: true)
            }
        }
    }
}



