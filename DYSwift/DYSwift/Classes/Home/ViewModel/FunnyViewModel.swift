//
//  FunnyViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/3/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {
    
}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
        
    }
}
