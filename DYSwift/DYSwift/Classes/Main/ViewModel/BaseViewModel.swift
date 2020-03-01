//
//  BaseViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/29.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool = true, URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .POST, URLString: URLString, parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            if isGroupData == true {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else {
                let anchorGroup = AnchorGroup()
                
                for dict in dataArray {
                    anchorGroup.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(anchorGroup)
            }
            
            
            finishedCallback()
        }
    }
}
