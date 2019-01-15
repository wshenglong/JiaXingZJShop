//
//  WebViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class WebViewController: BaseViewController {
    
    fileprivate var webView = UIWebView(frame: ScreenBounds)
    fileprivate var urlStr: String?
    fileprivate let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 3))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.addSubview(webView)
        webView.addSubview(loadProgressAnimationView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(navigationTitle: String, urlStr: String) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.loadRequest(URLRequest(url: URL(string: urlStr)!))
        self.urlStr = urlStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildRightItemBarButton()
        
        view.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        webView.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        webView.delegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    fileprivate func buildRightItemBarButton() {
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        rightButton.setImage(UIImage(named: "v2_refresh"), for: UIControl.State())
        rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -53)
        rightButton.addTarget(self, action: #selector(refreshClick), for: UIControl.Event.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    // MARK: - Action
    @objc func refreshClick() {
        if urlStr != nil && urlStr!.count > 1 {
            webView.loadRequest(URLRequest(url: URL(string: urlStr!)!))
        }
    }
}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}
