//
//  RecommendViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/28.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90.0

class RecommendViewController: BaseAnchorViewController {
    
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

// MARK:- 设置UI界面内容
extension RecommendViewController {
    
}


extension RecommendViewController {
    override func loadData() {
        
        baseVM = recommendVM
        
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let collectionCell  = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionPrettyCellID, for: indexPath) as! CollectionPrettyCell
            collectionCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return collectionCell
        }
        
        return super.collectionView(collectionView, cellForItemAt: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
