//
//  CollectionViewPrettyCell.swift
//  DYSwift
//
//  Created by CXTretar on 2020/1/30.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
