//
//  RecommendViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var bigdataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

// MARK:- 加载网络数据
extension RecommendViewModel {
    func requestData(finishedCallback: @escaping ()->()) {
        // 设置异步请求线程组
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .POST, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                
                return
            }
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.bigdataGroup.tag_name = "热门"
            self.bigdataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                //                print(anchor.description)
                self.bigdataGroup.anchors.append(anchor)
            }
            print("finish1")
            dispatchGroup.leave()
        }
        
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        dispatchGroup.enter()
        NetworkTools.requestData(type: .POST, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                
                return
            }
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            print("finish2")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .POST, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            // 2.1.创建组
            let group = AnchorGroup()
            
            // 2.2.遍历dataArray的所有的字典
            for dict in dataArray {
                group.anchors.append(AnchorModel(dict: dict))
            }
            
            // 2.3.将group,添加到anchorGroups
            self.anchorGroups.append(group)
            print("finish3")
            dispatchGroup.leave()
        }
        
        // 完成回调
        dispatchGroup.notify(queue: .main) {
            print("finish")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigdataGroup, at: 0)
            finishedCallback()
        }
    }
}
