//
//  CustomNavigationController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/3/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        /**
         之前的做法
         let target = interactivePopGestureRecognizer?.delegate
         
         let gesPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
         
         gesView.addGestureRecognizer(gesPan)
         */
        
        /**
         使用运行时机制的做法, 查看所有的属性名称
         
              var count: UInt32 = 0
              let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
         
              for i in 0..<count {
                  let ivar = ivars![Int(i)]
                  guard let name = ivar_getName(ivar)  else { return }
                  print(String(cString: name))
              }
         */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {
            return
        }
        
        guard let target = targetObjc.value(forKey: "target")else {
            return
        }
        
        let action = Selector(("handleNavigationTransition:"))
        
        let gesPan = UIPanGestureRecognizer(target: target, action: action)
        
        gesView.addGestureRecognizer(gesPan)
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
