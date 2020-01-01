//
//  UIBarButtonItem-Extension.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func createItem(imageName:String, highImageName:String = "", size:CGSize = .zero) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == .zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        return UIBarButtonItem(customView: btn)
    }
    // 便利构造函数需要满足2个条件: 1> 开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience  init(imageName:String, highImageName:String = "", size:CGSize = .zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == .zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        self.init(customView:btn)
    }
}
