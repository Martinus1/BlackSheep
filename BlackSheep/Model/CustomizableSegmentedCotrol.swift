//
//  CustomizableSegmentedCotrol.swift
//  BlackSheep
//
//  Created by Martin Michalko on 03/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

@IBDesignable
class CustomizableSegmentedCotrol: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 0.9652537983) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = mainColor {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont(name: "Quicksand-SemiBold", size: 17)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        let selectorWidth = (screenSize.width/2)
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    

        selector = UIView(frame: CGRect(x: 0, y: frame.maxY - 7, width: selectorWidth, height: 7))
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    

    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = buttonIndex
    
                let selectorStartPosition = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                
                btn.setTitleColor(selectorTextColor, for: .normal)
            
            }
        }
        sendActions(for: .valueChanged)
    }
    
}
