//
//  CreateTaskVC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 16/09/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit
import CoreData

struct scrollViewDataStruct {
    let title : String?
    let color : UIColor?
}

class CreateTaskVC: UIViewController, UITextFieldDelegate{
    
    var taskVC: TaskVC!

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var descriptionBox: UITextView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var locationSwitch: UISwitch!
    
    @IBOutlet weak var addBtn: addTaskBtn!
    @IBOutlet weak var emojiBtn: UIButton!
    @IBOutlet weak var editCategoriesBtn: UIButton!
    
    @IBOutlet weak var nameUderline: UIView!
    @IBOutlet weak var descriptionUnderline: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var coverUpView: UIView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    
//Button Outlets
    @IBOutlet weak var mondayBtn: weekBtn!
    @IBOutlet weak var tuesdayBtn: weekBtn!
    @IBOutlet weak var wednesdayBtn: weekBtn!
    @IBOutlet weak var thursdayBtn: weekBtn!
    @IBOutlet weak var fridayBtn: weekBtn!
    @IBOutlet weak var saturdayBtn: weekBtn!
    @IBOutlet weak var sundayBtn: weekBtn!
    
    var categories: [Category] = []
    
    var tasks: [Task] = []
    var tasks1: [Task] = []
    var tasks2: [Task] = []
    var tasks3: [Task] = []
    var tasks4: [Task] = []
    var tasks5: [Task] = []
    var tasks6: [Task] = []
    var tasks7: [Task] = []
    
    var underlineColorActive = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var underlineColorDormant = dormantColor
    var selectedCategory = "Default"
    var selectedColor = -1
    
    var startTimeValue: Int32 = 0
    var endTimeValue: Int32 = 0
    var timeDifference: Int = 0
    
    var changingStartTimeVal: Bool = true {
        willSet(newValue) {
            if newValue == true {
                UIView.animate(withDuration: 0.3) {
                    self.startTimeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.endTimeLabel.textColor = dormantColor
                }

            } else {
                UIView.animate(withDuration: 0.3) {
                    self.startTimeLabel.textColor = dormantColor
                    self.endTimeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }

            }
        }
    }
    
    var valueChanged: Bool = false
    var isEditCategoriesEnabled = true
    
    var buttons: [CategoryBtn] = []
    var deleteBtns: [UIButton] = []
    var categoriesArr: [Category] = []
    
    
    var scrollViewData = [scrollViewDataStruct]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryScrollView.delegate = self
        fetchCoreDataObjects()
        setupView()
        let vc = storyboard?.instantiateViewController(withIdentifier: "EmojiSelectorVC") as! EmojiSelectorVC
        setupScrollView()
        emojiBtn.setTitle(emojiBtnText, for: .normal)
        print(categories)
        timeSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        let startGesture = UITapGestureRecognizer(target: self, action:  #selector(startTimeLblPressed(_:)))
        let endGesture = UITapGestureRecognizer(target: self, action:  #selector(endTimeLblPressed(_:)))
        startTimeLabel.isUserInteractionEnabled = true
        startTimeLabel.addGestureRecognizer(startGesture)
        endTimeLabel.isUserInteractionEnabled = true
        endTimeLabel.addGestureRecognizer(endGesture)
        changingStartTimeVal = true
        valueChanged = false
        
        taskName.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        taskName.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dates = ""
        emojiBtn.setTitle(emojiBtnText, for: .normal)
        valueChanged = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        setupCategoryScrollView()
        emojiBtn.setTitle(emojiBtnText, for: .normal)
        
        startTimeValue = 600
        startTimeLabel.text = String(Int(startTimeValue).toHrs)
        endTimeValue = 750
        startTimeLabel.text = String(Int(endTimeValue).toHrs)
        
        timeDifference = Int(startTimeValue - endTimeValue)
        
        editCategoriesBtn.sendActions(for: .touchUpInside)
        if isEditCategoriesEnabled == true {
            editCategoriesBtn.sendActions(for: .touchUpInside)
        }
        
        mondayBtn.unselectedSecondary()
        tuesdayBtn.unselectedSecondary()
        wednesdayBtn.unselectedSecondary()
        thursdayBtn.unselectedSecondary()
        fridayBtn.unselectedSecondary()
        saturdayBtn.unselectedSecondary()
        sundayBtn.unselectedSecondary()
        
        
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
        
            }
        }
    }
    
    @IBAction func backeBtnPressed(_ sender: Any) {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
    
    
    func setupView() {
        topView.layer.cornerRadius = 15
        colorView.layer.cornerRadius = 15
        descriptionUnderline.backgroundColor = underlineColorDormant
        taskName.attributedPlaceholder = NSAttributedString(string: "eg. Walk my duck",attributes: [NSAttributedString.Key.foregroundColor: dormantColor ])
    }
    
    @objc func startTimeLblPressed(_ sender: UILabel) {
        changingStartTimeVal = true
        timeSlider.value = Float(startTimeValue)
    }
    
    @objc func endTimeLblPressed(_ sender: UILabel) {
        changingStartTimeVal = false
        timeSlider.value = Float(endTimeValue)
     }

    
    func setupScrollView() {
    
        scrollViewData = [scrollViewDataStruct.init(title: "First", color: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))]
        
        categoryScrollView.contentSize.width = self.categoryScrollView.frame.width * CGFloat(scrollViewData.count)
        
        for data in scrollViewData {
            let view = UIView(frame: CGRect(x: 5, y: 0, width: 50, height: 20))
            self.categoryScrollView.addSubview(view)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 25
    }
    
    
    func sortTasks() {
        tasks1 = []
        tasks2 = []
        tasks3 = []
        tasks4 = []
        tasks5 = []
        tasks6 = []
        tasks7 = []
        for element in tasks {
            if element.days!.contains("1") {
                tasks1.append(element)
            }
            if element.days!.contains("2") {
                tasks2.append(element)
            }
            if element.days!.contains("3") {
                tasks3.append(element)
            }
            if element.days!.contains("4") {
                tasks4.append(element)
            }
            if element.days!.contains("5") {
                tasks5.append(element)
            }
            if element.days!.contains("6") {
                tasks6.append(element)
            }
            if element.days!.contains("7") {
                tasks7.append(element)
            }
        }
    }
    
    //emoji picker
    
    @IBAction func emojiBtnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EmojiSelectorVC") as! EmojiSelectorVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    //
    // Sliders
    //
    @IBAction func sliderValueChng(_ sender: UISlider) {
        
        let roundedStepValue = Int(round(sender.value / 5) * 5)
        if changingStartTimeVal == true {
            
            if startTimeValue <= 1435 {
                startTimeValue = Int32(roundedStepValue)
                startTimeLabel.text = (Int(startTimeValue)).toHrs
            }
            
            if startTimeValue > 1435 {
                startTimeValue = Int32(roundedStepValue - 5)
                startTimeLabel.text = (Int(startTimeValue)).toHrs

            }
            
            if endTimeValue >= 1435 {
                endTimeValue = Int32(1440)
                endTimeLabel.text = (1440).toHrs
            }
            
            if startTimeValue >= endTimeValue {
                endTimeValue = Int32(roundedStepValue + 5)
                endTimeLabel.text = (Int(endTimeValue)).toHrs
            }
            

        } else if changingStartTimeVal == false {
            if endTimeValue > startTimeValue {
                endTimeLabel.text = (Int(roundedStepValue)).toHrs
                endTimeValue = Int32(roundedStepValue)
            } else if endTimeValue <= startTimeValue {
                
                startTimeLabel.text = (Int(roundedStepValue - 5)).toHrs
                startTimeValue = Int32(roundedStepValue - 5)
            }
            
            if endTimeValue >= 5 {
                endTimeLabel.text = (Int(roundedStepValue)).toHrs
                endTimeValue = Int32(roundedStepValue)
            }
            
            if endTimeValue < 5 {
                endTimeLabel.text = (Int(roundedStepValue + 5)).toHrs
                endTimeValue = Int32(roundedStepValue + 5)
                
                startTimeLabel.text = (0).toHrs
                startTimeValue = Int32(0)
            }
            
        }
        
    }

    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                // handle drag moved
                break
            case .ended:
                if valueChanged == false {
                    changingStartTimeVal = false
                    timeSlider.value = Float(endTimeValue)
                    valueChanged = true
                }
                timeDifference = Int(endTimeValue - startTimeValue)
                print(timeDifference)
                break
            default:
                break
            }
        }
    }
    
    //
    // Dates
    //
    @IBAction func mondayBtnPressed(_ sender: Any) {
        editDates(1)
        btnPressed(mondayBtn)
    }
    @IBAction func tuesdayBtnPressed(_ sender: Any) {
        editDates(2)
        btnPressed(tuesdayBtn)
    }
    @IBAction func wedesdayBtnPressed(_ sender: Any) {
        editDates(3)
        btnPressed(wednesdayBtn)
    }
    @IBAction func thursdayBtnPressed(_ sender: Any) {
        editDates(4)
        btnPressed(thursdayBtn)
    }
    @IBAction func fridayBtnPressed(_ sender: Any) {
        editDates(5)
        btnPressed(fridayBtn)
    }
    @IBAction func saturdayBtnPressed(_ sender: Any) {
        editDates(6)
        btnPressed(saturdayBtn)
    }
    @IBAction func sundayBtnPressed(_ sender: Any) {
        editDates(7)
        btnPressed(sundayBtn)
    }
    
    func btnPressed(_ button: weekBtn){
        button.toggleSecondarySelected()
    }
    
    //
    // date function
    //
    func editDates(_ n: Int) {
        if dates.contains(String(n)) {
            dates = dates.replacingOccurrences(of: String(n), with: "")
            print(dates)
        } else {
            dates = dates + String(n)
            print(dates)
        }
    }
    

    
    //
    // Task Created
    //

    @IBAction func addBtnWasPressed(_ sender: Any) {
        //verify that the text is not empty or bs
        self.save { (complete) in
            if complete {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func editCategories(_ sender: Any) {
        if isEditCategoriesEnabled == true {
            for btn in deleteBtns {
                btn.isEnabled = false
                btn.isHidden = true
            }
            isEditCategoriesEnabled = false
        } else {
            for btn in deleteBtns {
                btn.isEnabled = true
                btn.isHidden = false
            }
            isEditCategoriesEnabled = true
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        if dates != "" {
            let task = Task(context: managedContext)
            task.taskName = taskName.text
            task.taskStartTime = startTimeValue
            task.taskEndTime = endTimeValue
            task.taskDescription = ""
            task.days = dates
            task.taskIsPermanent = isPermanent
            task.taskEmoji = emojiBtnText
            task.taskCategory = selectedCategory
            task.color = Int32(selectedColor)
        }
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //
    //POPUP NEW CATEGORY
    //
//    @IBAction func dismissCategoryBtnPressed(_ sender: Any) {
//        animateOut()
//
//    }
//    @IBAction func addCategoryBtnPressed(_ sender: Any) {
//    }
    
//    func animateIn() {
//        self.view.addSubview(newCategoryView)
//        newCategoryView.center = self.view.center
//
//        newCategoryView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
//        newCategoryView.alpha = 0
//
//        UIView.animate(withDuration: 0.4) {
//            self.newCategoryView.alpha = 1
//            self.newCategoryView.transform = CGAffineTransform.identity
//
//        }
//    }
    
//    func animateOut() {
//
//        UIView.animate(withDuration: 0.3, animations: {
//            self.newCategoryView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
//            self.newCategoryView.alpha = 0
//        }) { (sucess) in
//            self.newCategoryView.removeFromSuperview()
//        }
//    }
    
}


extension CreateTaskVC: UIScrollViewDelegate {
    
    
    func setupCategoryScrollView() {
        
        var viewWidth =  0
        
        let spacing = 20
        let categoryBoxHeight = 50
        var categoryBtnWidth = 70
        
        let categoryButtonHeight = 30
        let categoryButtonY = Int((50 / 2) - (categoryButtonHeight/2))
        
        var nextX:Int = categoryBtnWidth + 15 + 10
        
        buttons = []
        deleteBtns = []
        categoriesArr = []
        

        for element in categories {
            categoriesArr.append(element)
        }
        
        for subview in categoryScrollView.subviews {
            subview.removeFromSuperview()
        }
        
        let addCategoryBtn = UIButton()
            
        for i in -1..<categories.count {
            
            let categoryBox = UIView()
            let categoryName = UILabel()
            let button = CategoryBtn()
            let deleteBtn = UIButton()
            
            
            categoryName.numberOfLines = 1
            
            if i == -1 {
                categoryName.text = "Default"
            } else {
                categoryName.text = categoriesArr[i].name
            }
            
            categoryName.font = UIFont(name: "Quicksand-SemiBold", size: 15)
            categoryName.textAlignment = .center
            categoryName.sizeToFit()
            categoryName.textColor = mainColor
            
            let categoryBoxWidth = Int(categoryName.frame.width + 60) + (spacing)
            

            let categoryButtonWidth = Int(categoryName.frame.width + 60) + spacing / 4
            
                
            categoryBox.frame = CGRect(x: nextX, y: 0, width: categoryBoxWidth, height: categoryBoxHeight)
            categoryBox.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 0)
            categoryBox.layer.cornerRadius = categoryBox.frame.height / 4
            
            
            button.frame = CGRect(x: CGFloat(spacing/4), y: CGFloat(categoryButtonY), width: CGFloat(categoryButtonWidth) , height: CGFloat(categoryButtonHeight))
            button.layer.cornerRadius = button.frame.height / 4
            
            if i == -1 {
                button.backgroundColor = #colorLiteral(red: 0.462745098, green: 0.1019607843, blue: 0.462745098, alpha: 1)
                button.titleLabel!.text = "Default"
                button.titleLabel!.backgroundColor = #colorLiteral(red: 0.462745098, green: 0.1019607843, blue: 0.462745098, alpha: 1)
            } else {
                button.backgroundColor = colors[Int(categoriesArr[i].color)]
                button.titleLabel!.text = categoriesArr[i].name
                button.titleLabel!.backgroundColor = colors[Int(categoriesArr[i].color)]
            }
            button.addTarget(self, action:  #selector(categoryElementPressed), for: .touchUpInside)
            
            categoryName.frame = CGRect(x: (categoryBox.frame.width / 2) - (categoryName.frame.width/2), y: CGFloat(categoryButtonY), width: categoryName.frame.width , height: CGFloat(categoryButtonHeight))
            
            categoryScrollView.addSubview(categoryBox)
            categoryBox.addSubview(button)
            categoryBox.addSubview(categoryName)
            
            if i != -1 {
                deleteBtn.frame = CGRect(x: -3 , y: 0, width: 20 , height: 20)
                deleteBtn.setTitle("x", for: .normal)
            
                deleteBtn.layer.borderWidth = 2
                deleteBtn.layer.cornerRadius   = deleteBtn.frame.height / 2
                deleteBtn.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
                deleteBtn.addTarget(self, action:  #selector(deleteCategoryElementPressed), for: .touchUpInside)
                
                categoryBox.addSubview(deleteBtn)
            }
            
            
            nextX += Int(categoryBox.frame.width)
            
            viewWidth = nextX
            
            buttons.append(button)
            deleteBtns.append(deleteBtn)
            

            print(categoryBox)
                
            }
        
        addCategoryBtn.frame = CGRect(x: 15, y: categoryButtonY, width: categoryBtnWidth , height: categoryButtonHeight)
        addCategoryBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        addCategoryBtn.backgroundColor      = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        addCategoryBtn.titleLabel?.font     = UIFont(name: "Quicksand-Light", size: 20)
        addCategoryBtn.contentHorizontalAlignment = .center
        addCategoryBtn.contentVerticalAlignment = .center
        addCategoryBtn.setTitle("+", for: .normal)
        addCategoryBtn.layer.cornerRadius   = CGFloat(categoryButtonHeight / 4)
        addCategoryBtn.addTarget(self, action:  #selector(addCategoryElementPressed), for: .touchUpInside)
        
        categoryScrollView.addSubview(addCategoryBtn)
        
        self.categoryScrollView.contentSize = CGSize(width: viewWidth, height: 50)
        
    }
    
    @objc func categoryElementPressed(_ sender: CategoryBtn) {
        for btn in buttons {
            btn.unSelect()
        }
        sender.select()
        selectedCategory = sender.titleLabel!.text!
        if let c = colors.firstIndex(of: sender.backgroundColor!) {
            selectedColor = c
        } else {
            selectedColor = -1
        }

        
        coverUpView.backgroundColor = sender.backgroundColor
        mainScrollView.backgroundColor = sender.backgroundColor
        topView.backgroundColor = sender.backgroundColor
        colorView.backgroundColor = sender.backgroundColor
        mainView.backgroundColor = sender.backgroundColor
        reminderSwitch.onTintColor = sender.backgroundColor
        locationSwitch.onTintColor = sender.backgroundColor
    }
    
    @objc func addCategoryElementPressed(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CreateCategoryVC") as! CreateCategoryVC
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)

    }
    
    @objc func deleteCategoryElementPressed(_ sender: UIButton) {
        
        guard let index = deleteBtns.firstIndex(of: sender) else {
            return
        }
        let category = categoriesArr[index]
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Delete Category", message: "Are you sure you want to delete \"\(category.name!)\"? This action may create some changes." , preferredStyle: .alert)
        
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            print("Ok button tapped")
            
            print(self.categories.count)
            
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            managedContext.delete(category)
            
            do  {
                try managedContext.save()
                    print("sucessfull delete")
                    
                } catch {
                    debugPrint("Could not fetch: \(error.localizedDescription)")
                }
            
            self.fetchCoreDataObjects()
            print(self.categories.count)
            self.setupCategoryScrollView()

   
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
            return
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }


}

extension CreateTaskVC {
    
    func fetch(completion: (_ complete: Bool) ->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do  {
            categories = try managedContext.fetch(fetchRequest)
            
            completion(true)
            print("sucessfully fetched data")
            
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}



