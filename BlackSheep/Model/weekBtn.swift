//
//  weekBtn.swift
//  BlackSheep
//
//  Created by Martin Michalko on 14/11/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class weekBtn: UIButton {
    
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
        backgroundColor      = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 0)
        layer.borderColor    = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        titleLabel?.font     = UIFont(name: "Quicksand-SemiBold", size: 14)
    }
    
    func toggleMainSelected(){
        if layer.borderColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
            self.selectedMain()
        } else {
            self.unselectedMain()
        }
    }
    
    func selectedMain() {
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        layer.cornerRadius   = (layer.frame.width/2)
        layer.borderWidth    = 2
        layer.borderColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func unselectedMain(){
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5490196078), for: .normal)
        layer.borderColor    = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    func toggleSecondarySelected(){
        if layer.borderColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
            self.selectedSecondary()
        } else {
            self.unselectedSecondary()
        }
    }
    
    func selectedSecondary() {
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        layer.cornerRadius   = (layer.frame.width/2)
        layer.borderWidth    = 2
        layer.borderColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func unselectedSecondary(){
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5490196078), for: .normal)
        layer.borderColor    = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    func today() {
        titleLabel?.font     = UIFont(name: "Quicksand-Bold", size: 14)
    }
    
    
}
