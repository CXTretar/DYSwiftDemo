//
//  CollectionGameCell.swift
//  DYSwift
//
//  Created by CXTretar on 2020/2/25.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : BaseGameModel? {
        didSet {
            titleLabel.text = group?.tag_name

            if let iconUrl = URL(string: group?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconUrl)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }

}
