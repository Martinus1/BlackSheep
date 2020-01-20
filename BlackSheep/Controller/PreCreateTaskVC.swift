//
//  PreCreateTaskVC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 22/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.


import UIKit

class PreCreateTaskVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var permanentTaskView: UIView!
    @IBOutlet weak var oneTimeTaskView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        self.scrollView.contentSize = CGSize(width: screenSize.width, height: 900)

        permanentTaskView.layer.cornerRadius = 8
        oneTimeTaskView.layer.cornerRadius = 8
        

    }

    @IBAction func permanentTaskBtnPressed(_ sender: Any) {
        isPermanent = true
        let VC = storyboard?.instantiateViewController(withIdentifier: "CreateTaskVC") as! CreateTaskVC
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(VC, animated: false, completion: nil)
    }

    @IBAction func oneTimeTaskBtnPressed(_ sender: Any) {
        isPermanent = false
        let VC = storyboard?.instantiateViewController(withIdentifier: "CreateTaskVC") as! CreateTaskVC
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(VC, animated: false, completion: nil)
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getPeopleTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTaskCell") as? PresetCell{
            let personTask = DataService.instance.getPeopleTasks()[indexPath.row]
            cell.updateViews(personTask: personTask)
            return cell
        } else {
            return PresetCell()
        }
    }

}

