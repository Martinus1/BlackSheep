//
//  TaskDetailsVC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 11/11/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailsVC: UIViewController {

    //outlets
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskStartTime: UILabel!
    @IBOutlet weak var taskEndTime: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    
    var task: Task? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskName.text = task!.taskName
        taskStartTime.text = String(Int(task!.taskStartTime).toHrs)
        taskEndTime.text = String(Int(task!.taskEndTime).toHrs)
        taskDescription.text = ""
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editTaskBtnPressed(_ sender: Any) {
        let editVC = storyboard?.instantiateViewController(withIdentifier: "EditTasksVC") as! EditTaskVC
        editVC.task = task
        present(editVC, animated: true, completion: nil)
    }
    
    @IBAction func deleteTaskBtnPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(task!)
        
        do  {
            try managedContext.save()
                print("sucessfull delete")
                
            } catch {
                debugPrint("Could not fetch: \(error.localizedDescription)")
            }
        
         dismiss(animated: true, completion: nil)

    }
}
