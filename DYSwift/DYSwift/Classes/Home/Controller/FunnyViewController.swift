//
//  FunnyViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/3/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    
    private lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        super.loadData()
        
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
}
