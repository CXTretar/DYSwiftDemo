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
    func loadAnchorData(URLString: String, parameters: [String : String]? = nil, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .POST, URLString: URLString, parameters: parameters) { (result) in

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
