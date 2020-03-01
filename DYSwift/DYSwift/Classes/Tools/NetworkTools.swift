//
//  NetworkTools.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/31.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
    class func requestData(type: MethodType, URLString: String, parameters: [String : Any]? = nil, finishedCallback:  @escaping (_ result: Any) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error ?? "request error!")
                return
            }
            
            finishedCallback(result)
        }
        
    }

}
