//
//  RecommendViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/28.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPrettyItemH = kNormalItemW * 4 / 3

private let kCollectionNormalCellID = "kCollectionNormalCellID"
private let kCollectionPrettyCellID = "kCollectionPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    
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
        view.backgroundColor = .orange;
        
        setupUI()
    }
    
}

extension RecommendViewController {
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        loadData()
    }
}

extension RecommendViewController {
    private func loadData() {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: nil) { (result) in
            print(result)
        }
    }
}

extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionCell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            collectionCell  = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionPrettyCellID, for: indexPath)
        }else {
            collectionCell  = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionNormalCellID, for: indexPath)
        }
        
        return collectionCell;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
    
}
