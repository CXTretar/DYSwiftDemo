//
//  HomeViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kPageTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView: PageTitleView = {
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        
        return pageTitleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleViewH
        let contentY = kStatusBarH + kNavigationBarH + kPageTitleViewH
        let contentFrame = CGRect(x: 0, y:contentY, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVCs = [UIViewController]()
        for i in 0..<4 {
            let childVC = UIViewController()
            childVC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(childVC)
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
       
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
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
    
    private func setTitleView() {
        
    }
}
