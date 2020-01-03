//
//  PageTitleView.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/2.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleSelect(_ titleView: PageTitleView, _ index:Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 165, 0)

class PageTitleView: UIView {
    private var titles: [String]
    private var titleLabels: [UILabel] = [UILabel]()
    private var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    // MARK:- 懒加载属性
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            label.tag = index
            // 4.给Label添加手势
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleLabelSelect(_:))))
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
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.2.设置scrollLine的属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        addSubview(scrollLine)
    }
}

// MARK:-  监听Label的点击
extension PageTitleView {
    @objc private func titleLabelSelect(_ tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        
        // 2.切换文字的颜色
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        currentIndex = currentLabel.tag
        
        // 3.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * currentLabel.frame.width
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 4.通知代理
        delegate?.pageTitleSelect(self, currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(_ progress: CGFloat, _ sourceIndex: Int, _ targetIndex: Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveDeltaX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveDeltaX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
//        print("progress \(progress), source \(sourceIndex), target \(targetIndex)")
    }
    
}
