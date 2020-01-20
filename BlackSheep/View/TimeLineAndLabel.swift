//
//  TimeLineAndLabel.swift
//  BlackSheep
//
//  Created by Martin Michalko on 18/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class TimeLineAndLabel {
        
    let label = UILabel()
    let line = UIView()
        
    init(scrollView: UIScrollView) {
            let viewHeight =  screenSize.height * CGFloat(1.2)
        
            let hour = Calendar.current.component(.hour, from: Date())
            let minute = Calendar.current.component(.minute, from: Date())
            let currentMinutes:Double = Double(hour*60) + Double(minute)
            let currentHours:Double = Double(currentMinutes / 60)
            print(currentHours)
    
            
            let labelWidth = Int(screenSize.width/10)
            let labelY = currentHours * Double(screenSize.height * 1.2 / 24)
            
            label.frame = CGRect(x: 0, y: Int(labelY) - 10 , width: labelWidth , height: 20)
            label.textColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.2666666667, alpha: 1)
            label.textAlignment = .right
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = "\((currentHours * 60).toHrs)"
            
            label.font = UIFont(name: "Quicksand-SemiBold", size: 12)
            line.frame = CGRect(x: label.frame.maxX + 10, y: CGFloat(labelY), width: CGFloat(Int(screenSize.width) - labelWidth), height: CGFloat(0.5) )

            
            if currentMinutes == 24 {
                label.text = "\((0).toHrs)"
            } else {
                label.text = "\((currentHours * 60).toHrs)"
            }
            
            line.backgroundColor = #colorLiteral(red: 1, green: 0.2549019608, blue: 0.4117647059, alpha: 1)
            line.layer.zPosition = 10
            scrollView.addSubview(label)
            scrollView.addSubview(line)
    }
    
    func updateTimeLine() {
        UIView.animate(withDuration: 0.1) {
            let hour = Calendar.current.component(.hour, from: Date())
            let minute = Calendar.current.component(.minute, from: Date())
            let currentMinutes:Double = Double(hour*60) + Double(minute)
            let currentHours:Double = Double(currentMinutes / 60)
            
                    
            let labelWidth = Int(screenSize.width/10)
            let labelY = currentHours * Double(screenSize.height * 1.2 / 24)
            self.line.frame.origin.y = CGFloat(labelY)
            self.label.frame.origin.y = CGFloat(labelY)
        }
    }

}
