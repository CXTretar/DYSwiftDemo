//
//  AnchorGroup.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
 
    /// 组显示的图标
    @objc var icon_name : String = "home_header_normal"

    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    /// 该组中对应的房间信息
    @objc var room_list : [[String:NSObject]]? {
         didSet {
             guard let room_list = room_list else { return }
             for dict in room_list {
                 anchors.append(AnchorModel(dict: dict))
             }
         }
     }
}
