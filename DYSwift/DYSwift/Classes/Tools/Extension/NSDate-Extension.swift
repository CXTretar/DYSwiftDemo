//
//  NSDate-Extension.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let currentDate = Date()
        let interval = Int(currentDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
