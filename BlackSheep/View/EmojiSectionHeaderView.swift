//
//  EmojiSectionHeaderView.swift
//  BlackSheep
//
//  Created by Martin Michalko on 23/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class EmojiSectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var categoryTitle: String! {
        didSet {
            categoryTitleLabel.text = categoryTitle
        }
    }
}
