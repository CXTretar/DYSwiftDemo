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
    
    private lazy var pageTitleView: PageTitleView = {
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        // 1.确定内容的frame
        let contentH : CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleViewH - kTabbarH
        let contentY = kStatusBarH + kNavigationBarH + kPageTitleViewH
        let contentFrame = CGRect(x: 0, y:contentY, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        
        for i in 0..<1 {
            let childVC = UIViewController()
            childVC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(childVC)
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
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

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleSelect(_ titleView: PageTitleView, _ index: Int) {
        
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController: PageContentViewDelegate {
    func pageContentViewScroll(_ contentView: PageContentView, _ progress: CGFloat, _ sourceIndex: Int, _ targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress, sourceIndex, targetIndex)
        
    }
}
