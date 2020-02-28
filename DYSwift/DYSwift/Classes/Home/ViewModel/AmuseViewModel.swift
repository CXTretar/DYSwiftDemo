//
//  AmuseViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/29.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .POST, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
