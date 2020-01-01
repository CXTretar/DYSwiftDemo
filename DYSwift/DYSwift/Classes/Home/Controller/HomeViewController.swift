//
//  HomeViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}

// MARK:- 设置UI界面
extension HomeViewController {
    
    
    private func setupUI() {
        // 1.设置导航栏
        setupNavgationBar()
    }
    
    private func setupNavgationBar() {
        // 1.设置左侧的Item
        let logoItem = UIBarButtonItem(imageName: "logo")
        
        self.navigationItem.leftBarButtonItem = logoItem
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}
