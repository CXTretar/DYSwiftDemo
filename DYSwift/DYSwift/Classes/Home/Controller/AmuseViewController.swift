//
//  AmuseViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/28.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
private let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90.0

private let kCollectionNormalCellID = "kCollectionNormalCellID"
private let kCollectionPrettyCellID = "kCollectionPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class AmuseViewController: UIViewController {
    
    private lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumInteritemSpacing = kItemMargin
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kCollectionNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kCollectionPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        // Do any additional setup after loading the view.
    }
    
}

// MARK:- 设置UI界面
extension AmuseViewController {
    func setupUI() {
        // 将菜单的View添加到collectionView中
        view.addSubview(collectionView)
    }
}

extension AmuseViewController {
    private func loadData() {
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

extension AmuseViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell =  collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionNormalCellID, for: indexPath) as! CollectionNormalCell
        
        collectionCell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return collectionCell;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = amuseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}
