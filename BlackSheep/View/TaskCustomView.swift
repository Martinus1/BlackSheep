//
//  TaskCustomView.swift
//  BlackSheep
//
//  Created by Martin Michalko on 11/11/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class TaskCustomView: UIView {

    var taskNameLbl: UILabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        taskNameLbl.frame = CGRect(x: 10, y: self.frame.height/2 - 25, width: 50, height: 20)
        taskNameLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        taskNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        taskNameLbl.textAlignment = NSTextAlignment.left
        self.addSubview(taskNameLbl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
