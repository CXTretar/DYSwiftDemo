//
//  RecommendViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
}

// MARK:- 加载网络数据
extension RecommendViewModel {
    func requestData() {
        // 1.定义参数
        let parameters = ["time" : Date.getCurrentTime()]
        print(Date.getCurrentTime())
        NetworkTools.requestData(type: .POST, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            print(result)
        }
    }
}
