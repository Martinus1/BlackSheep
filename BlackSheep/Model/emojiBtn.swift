//
//  emojiBtn.swift
//  BlackSheep
//
//  Created by Martin Michalko on 04/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class emojiBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        titleLabel?.font     = UIFont(name: "Quicksand-Light", size: 17)
        layer.cornerRadius   = self.frame.height/2
        
    }
    
}
