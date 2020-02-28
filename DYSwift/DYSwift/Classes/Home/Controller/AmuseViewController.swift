//
//  AmuseViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/28.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        // Do any additional setup after loading the view.
    }
    
}



extension AmuseViewController {
    override func loadData() {
        
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

