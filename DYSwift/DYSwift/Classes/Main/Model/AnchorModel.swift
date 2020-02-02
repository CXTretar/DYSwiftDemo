//
//  AnchorModel.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit
/**
 在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
 在swift4之后，编译器不再自动推断，你必须显式添加@objc
 */
class AnchorModel: NSObject {
    /// 房间ID
    @objc var room_id : Int = 0
    /// 房间图片对应的URLString
    @objc var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    @objc var isVertical : Int = 0
    /// 房间名称
    @objc var room_name : String = ""
    /// 主播昵称
    @objc var nickname : String = ""
    /// 观看人数
    @objc var online : Int = 0
    /// 所在城市
    @objc var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        get {
            let keys = ["room_id", "vertical_src", "isVertical", "room_name", "nickname", "online", "room_id", "anchor_city"]
            return dictionaryWithValues(forKeys: keys).description
        }
    }
}
