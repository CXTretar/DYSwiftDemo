//
//  MainViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyboardName: "Home")
        addChildVC(storyboardName: "Live")
        addChildVC(storyboardName: "Follow")
        addChildVC(storyboardName: "Profile")
       
    }
    
    private func addChildVC(storyboardName: String) -> Void {
        let childVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        addChild(childVC);
    }

}
