//
//  PageTitleView.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/2.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    private var titles: [String]
    private var titleLabels: [UILabel] = [UILabel]()
    
    // MARK:- 懒加载属性
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        
        return scrollLine
    }()
    
    private lazy var titleScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        
        return scrollView
    }()
    
    // MARK:- 自定义构造函数
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面
extension PageTitleView {
    fileprivate func setupUI() {
        // 1.添加UIScrollView
        
        titleScrollView.frame = bounds
        
        // 2.添加title对应的Label
        
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        // 0.确定label的一些frame的值
        let labelY: CGFloat = 0
        let labelW: CGFloat = bounds.size.width / CGFloat(titles.count)
        let labelH: CGFloat = bounds.size.height
        
        for (index, title) in titles.enumerated() {
            
            // 1.创建UILabel
            let label = UILabel()
            let labelX = labelW * CGFloat(index)
            // 2.设置label的frame
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 3.设置Label的属性
            label.text = title
            label.font = .systemFont(ofSize: 16)
            label.textColor = .darkGray
            label.textAlignment = .center
            addSubview(label)
            titleLabels.append(label)
        }
        
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        bottomLine.backgroundColor = .gray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = .orange
        
        // 2.2.设置scrollLine的属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        addSubview(scrollLine)
    }
}
