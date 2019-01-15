//
//  CoupinRuleViewController.swift
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.

import UIKit

class CoupinRuleViewController: BaseViewController {
    
    fileprivate let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - NavigationH))
    fileprivate let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 3))
    var loadURLStr: String? {
        didSet {
            webView.loadRequest(URLRequest(url: URL(string: loadURLStr!)!))
        }
    }
    
    var navTitle: String? {
        didSet {
            navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        buildWebView()
        webView.addSubview(loadProgressAnimationView)
    }
    
    fileprivate func buildWebView() {
        webView.delegate = self
        webView.backgroundColor = UIColor.white
        view.addSubview(webView)
    }
}

extension CoupinRuleViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}
