//
//  CollectionCycleCell.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/24.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title ?? ""
            
            if let iconUrl = URL(string: cycleModel?.pic_url ?? "") {
                iconImageView.kf.setImage(with: iconUrl)
            } else {
                iconImageView.image = UIImage(named: "Img_default")
            }
        }
    }
    

}
