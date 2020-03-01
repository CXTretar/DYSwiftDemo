//
//  BaseAnchorViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/29.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

let kNormalItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3

let kCollectionNormalCellID = "kCollectionNormalCellID"
let kCollectionPrettyCellID = "kCollectionPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {
    
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        
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
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
}

// MARK:- 设置UI界面
extension BaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        
        // 将菜单的View添加到collectionView中
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

// MARK:- 加载数据
extension BaseAnchorViewController {
    @objc func loadData() {
        
    }
}

// MARK:- 遵守UICollectionView的数据源
extension BaseAnchorViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell =  collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionNormalCellID, for: indexPath) as! CollectionNormalCell
        
        collectionCell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return collectionCell;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

extension BaseAnchorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchorModel = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        anchorModel.isVertical == 1 ? presentShowRoomVc() : pushNormalRoomVc()
        
    }
    
    private func presentShowRoomVc() {
        let showRoomVC = RoomShowViewController()
         /**
         iOS13更新之后，present到新的页面，没有全屏显示，这是因为增加了一个控制器属性modalPresentationStyle，默认值是auto，也就不是全屏的，我们可以在present之前修改此属性为.fullScreen
         
         */
//        showRoomVC.modalPresentationStyle = .fullScreen
        present(showRoomVC, animated: true, completion: nil)
    }
    private func pushNormalRoomVc() {
        let normalRoomVC = RoomNormalViewController()
        
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
}
