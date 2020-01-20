//
//  EditTaskController.swift
//  BlackSheep
//
//  Created by Martin Michalko on 11/11/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class EditTaskVC: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextView!
    @IBOutlet weak var taskStartTimeSlider: UISlider!
    @IBOutlet weak var taskEndTimeSlider: UISlider!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    var task: Task? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sliderStartValueChange(_ sender: UISlider) {
        
        
    }
    
    
    @IBAction func sliderEndValueChng(_ sender: UISlider) {

        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
