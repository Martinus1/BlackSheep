//
//  TimeConvertor.swift
//  BlackSheep
//
//  Created by Martin Michalko on 15/10/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

extension Int {
    var toHrs: String {
        let a = Int(floorf(Float(self / 60)))
        let b = Int(self % 60)
        
        if a < 10 && b < 10 {
            return "0\(a):0\(b)"
        } else if a < 10 && b >= 10{
            return "0\(a):\(b)"
        } else if a >= 10 && b < 10 {
            return "\(a):0\(b)"
        } else {
            return "\(a):\(b)"
        }
    }
    
    
    var toFormalHrs: String {
        let a = abs(Int32(floorf(Float(self / 60))))
        let b = abs(Int32(self % 60))
        
        if b != 0 && a != 0 {
            if a != 1 && b != 1 {
                return "\(a)hrs, \(b)min"
            } else {
                return "\(a)hr, \(b)min"
            }
        } else if a == 0 && b != 0 {
            return "\(b)min"
        }else if a != 0 && b == 0 {
            if a != 1 {
                return "\(a)hrs"
            } else {
                return "\(a)hr"
            }
        } else {
            return "0"
        }

    }
}

extension Double {
    
    var toHrs: String {
        let a = Int(floorf(Float(self / 60)))
        let b = Int(self) % 60
        
        
        if a < 10 && b < 10 {
            return "0\(a):0\(b)"
        } else if a < 10 && b >= 10{
            return "0\(a):\(b)"
        } else if a >= 10 && b < 10 {
            return "\(a):0\(b)"
        } else {
            return "\(a):\(b)"
        }
    }
}






