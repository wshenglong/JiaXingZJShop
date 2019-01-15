//
//  NetworkManager.swift
//  JiaXingZJShop
//
//  Created by jsonshenglong on 2019/1/15.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
// 基本框架配置及封装写到这里
/*
import Foundation
import Alamofire
import Moya

let provier = MoyaProvider<API>()


provier.request(.testApi) { (result) in
    switch result {
    case let .success(response):
        print(response)
    case let .failure(error):
        print("网络连接失败")
        break
    }
}


//provider.request(.login(phoneNum: 12345678901, passWord: 123456)) { result in
//    switch result {
//    case let .success(response):
//        //...............
//        break
//    case let .failure(error):
//        //...............
//        break
//    }
//}


/*设置httpheader公共请求参数
 在实际开发中我们可能会需要在请求头内添加一些公共请求参数，如用于识别一些平台标志、辨别接口的版本号。你可以定义一个Endpoint的闭包，
let publicParamEndpointClosure = { (target: AccountService) -> Endpoint<AccountService> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint = Endpoint<AccountService>(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding)
    return endpoint.adding(newHTTPHeaderFields: ["x-platform" : "iOS", "x-interface-version" : "1.0"])
}

 然后在创建请求的Provider把它添加上去，
 
 let provider = MoyaProvider(endpointClosure: publicParamEndpointClosure)
*/

 */
//https://www.cnblogs.com/jadonblog/p/6945974.html 资料
//https://www.cnblogs.com/phbk/p/8497019.html 资料2

