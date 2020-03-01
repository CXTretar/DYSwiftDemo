//
//  BaseViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/3/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView: UIView?
    
    private lazy var animateImageView: UIImageView = {[unowned self] in
        
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
}

extension BaseViewController {
    @objc func setupUI() {
        // 1.隐藏内容的View
        contentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        view.addSubview(animateImageView)
        
        // 3.给animImageView执行动画
        animateImageView.startAnimating()
        
        // 4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        // 1.停止动画
        animateImageView.stopAnimating()
        
        // 2.隐藏animImageView
        animateImageView.isHidden = true
        
        // 3.显示内容的View
        contentView?.isHidden = false
    }
}
