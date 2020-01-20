//
//  isPermanentSC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 14/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class isPermanentSC: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControl()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControl()
    }
    
    
    func setupControl() {
        let font: [AnyHashable : Any] = [NSAttributedString.Key.font : UIFont(name: "Quicksand-Bold", size: 14)]
        self.setTitleTextAttributes(font as! [NSAttributedString.Key : Any], for: .normal)
        let colorSelected: [AnyHashable : Any] = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.405998379, green: 0.005248470232, blue: 0.3856985569, alpha: 1)]
        self.setTitleTextAttributes(colorSelected as! [NSAttributedString.Key : Any], for: .selected)
        let colorUnselected: [AnyHashable : Any] = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2470588235),]
        self.setTitleTextAttributes(colorUnselected as! [NSAttributedString.Key : Any], for: .normal)
        
    }
    


}
