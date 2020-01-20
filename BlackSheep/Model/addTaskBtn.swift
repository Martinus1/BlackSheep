//
//  addTaskBtn.swift
//  BlackSheep
//
//  Created by Martin Michalko on 15/11/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class addTaskBtn: UIButton {

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
        layer.cornerRadius   = self.frame.height/2
        layer.borderWidth    = 2
        layer.borderColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    //not used
    private func setShadow() {
        layer.shadowColor   = #colorLiteral(red: 0.05882352941, green: 0.3921568627, blue: 0.9490196078, alpha: 1)
        layer.shadowOffset  = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius  = 5
        layer.shadowOpacity = 0.4
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    

    
}
