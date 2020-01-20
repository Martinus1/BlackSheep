//
//  PresetCell.swift
//  BlackSheep
//
//  Created by Martin Michalko on 28/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class PresetCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
//    @IBOutlet var image: UIImageView!

    func updateViews(personTask: PersonTask) {
        name.text = personTask.personName
        view.layer.cornerRadius = 8
//        image.image = UIImage(named: personTask.image)
        
    }

}
