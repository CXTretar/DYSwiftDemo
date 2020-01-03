//
//  PageContentView.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/2.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let ContentCellID: String = "ContentCellID"

protocol PageContentViewDelegate : class {
    func pageContentViewScroll(_ contentView: PageContentView, _ progress: CGFloat, _ sourceIndex: Int, _ targetIndex: Int)
}

class PageContentView: UIView {
    
    private var childVCs: [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
        }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        self.backgroundColor = .green
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    private func setupUI() {
        // 1.将所有的子控制器添加父控制器中
        for childVC in childVCs {
            parentViewController?.addChild(childVC)
        }
        
        // 2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell;
    }
    
}

// MARK:- UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex  : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX  {
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        // 通知代理
        delegate?.pageContentViewScroll(self, progress, sourceIndex, targetIndex)
    }
    
}

// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(_ currentIndex: Int) {
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
