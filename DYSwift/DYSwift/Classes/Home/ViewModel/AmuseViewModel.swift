//
//  AmuseViewModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/29.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        
        loadAnchorData(URLString:  "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
        
    }
}
