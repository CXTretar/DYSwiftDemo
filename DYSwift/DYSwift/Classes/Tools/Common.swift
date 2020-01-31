//
//  Common.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/2.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

let kScreenH: CGFloat = UIScreen.main.bounds.height
let kScreenW: CGFloat = UIScreen.main.bounds.width

let isIPhoneX: Bool = (kScreenH >= 812.0)

let kStatusBarH: CGFloat = UIApplication.shared.statusBarFrame.height
let kNavigationBarH: CGFloat = 44.0
let kTabbarH : CGFloat = isIPhoneX ? (49.0 + 34.0) : (49.0)

