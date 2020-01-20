//
//  TaskTypeBtn.swift
//  BlackSheep
//
//  Created by Martin Michalko on 20/11/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class TaskTypeBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        mainValues()
        
        
    }
    
    private func mainValues() {
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        backgroundColor      = mainColor
        titleLabel?.font     = UIFont(name: "Quicksand-Light", size: 14)
        layer.cornerRadius   = self.frame.height/2
    }
    
    
}

