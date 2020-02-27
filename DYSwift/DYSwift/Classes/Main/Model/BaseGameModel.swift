//
//  BaseGameModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/25.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 定义属性
   @objc var tag_name : String = ""
       /// 游戏分组对应的图标
   @objc var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
