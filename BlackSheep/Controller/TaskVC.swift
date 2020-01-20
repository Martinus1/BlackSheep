//
//  ViewController.swift
//  BlackSheep
//
//  Created by Martin Michalko on 09/09/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox
import UserNotifications


let appDelegate = UIApplication.shared.delegate as? AppDelegate

class TaskVC: UIViewController {

    //Outlets
    @IBOutlet weak var taskScrollView: UIScrollView!
    @IBOutlet weak var notesScrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var weekLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!

    //Buttons
    @IBOutlet weak var mondayBtn: weekBtn!
    @IBOutlet weak var tuesdayBtn: weekBtn!
    @IBOutlet weak var wednesdayBtn: weekBtn!
    @IBOutlet weak var thursdayBtn: weekBtn!
    @IBOutlet weak var fridayBtn: weekBtn!
    @IBOutlet weak var saturdayBtn: weekBtn!
    @IBOutlet weak var sundayBtn: weekBtn!
    @IBOutlet weak var switchBtn: UIButton!
    
    
    var tasks: [Task] = []
    var tasks1: [Task] = []
    var tasks2: [Task] = []
    var tasks3: [Task] = []
    var tasks4: [Task] = []
    var tasks5: [Task] = []
    var tasks6: [Task] = []
    var tasks7: [Task] = []
    
    
    //gesture and impact
    var gesture = UITapGestureRecognizer(target: self, action:  #selector(taskElementPressed))
    let impact = UIImpactFeedbackGenerator()
    
    
    //Variables
    let mainView = UIView()
    var tasksDayDict: [String: Array<Task>] = [:]
    var viewTaskDict: [UIView: Task] = [:]
    var btnDayDict: [String:weekBtn] = [:]
    var dayBtnDict: [weekBtn:String] = [:]
    var timeLabels: [UILabel] = []
    var day = "Monday"
    var today = ""
    var tommorow = ""
    let currentDatetime = Date()
    let now = Calendar.current.dateComponents(in: .current, from: Date())
    let textFormatter = DateFormatter()
    var dateTimeString = ""
    var isTaskFront: Bool = true {
        willSet(newValue) {
            if newValue == true {
                automaticRefreshView()
                taskScrollView.layer.zPosition = 1
                notesScrollView.layer.zPosition = 0
            } else {
                taskScrollView.layer.zPosition = 0
                notesScrollView.layer.zPosition = 1
            }
        }
    }
    
    //formatting
    var firstY = 0
    var lastY = 0
    
    
    let timeLabel = UILabel()
    let timeLine = UIView()
    
    
    
    var timeLineSetup = false
    
    var isDarkStatusBar = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day = "Monday"
        taskScrollView.delegate = self
        setupScrollView()
        textFormatter.dateFormat = "MMM d, yyyy"
        dateTimeString = textFormatter.string(from: currentDatetime)
        setupTimeLine()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
        taskScrollView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasksDayDict = [monday : tasks1, tuesday: tasks2, wednesday: tasks3, thursday: tasks4, friday: tasks5, saturday: tasks6, sunday: tasks7]
        fetchCoreDataObjects()
        automaticRefreshView()
        sortTasks()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksDayDict = [monday : tasks1, tuesday: tasks2, wednesday: tasks3, thursday: tasks4, friday: tasks5, saturday: tasks6, sunday: tasks7]
        fetchCoreDataObjects()
        automaticRefreshView()
        sortTasks()
        setupView()
    }
    
    
    func setupTimeLine() {
        
        for subview in taskScrollView.subviews {
            if subview == timeLine {
                subview.removeFromSuperview()
            }
            if subview == timeLabel {
                subview.removeFromSuperview()
            }
        }
        
        for object in self.timeLabels {
            object.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
             
        if day == today {
            let viewHeight =  screenSize.height * CGFloat(1.2)
               
            let hour = Calendar.current.component(.hour, from: Date())
            let minute = Calendar.current.component(.minute, from: Date())
            let currentMinutes:Double = Double(hour*60) + Double(minute)
            let currentHours:Double = Double(currentMinutes / 60)
           
            
            let labelWidth = Int(screenSize.width/10)
            let labelY = currentHours * Double(Int(screenSize.height * 1.2 / 24))
            
            timeLabel.frame = CGRect(x: 0, y: Int(labelY) , width: labelWidth , height: 20)
            timeLabel.textColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.2666666667, alpha: 1)
            timeLabel.textAlignment = .left
            timeLabel.lineBreakMode = .byWordWrapping
            timeLabel.numberOfLines = 1
            timeLabel.text = "77:77"
            
            timeLine.frame = CGRect(x: timeLabel.frame.maxX + 10, y: CGFloat(labelY) + (timeLabel.frame.size.height / 2), width: CGFloat(Int(screenSize.width) -    Int(screenSize.width/10)), height: CGFloat(1))
            
            timeLabel.sizeToFit()
            
            timeLabel.font = UIFont(name: "Quicksand-Bold", size: 12)


            
            if currentMinutes == 24 {
                timeLabel.text = "\((0).toHrs)"
            } else {
                timeLabel.text = "\((currentHours * 60).toHrs)"
            }
            timeLabel.sizeToFit()
            timeLabel.frame.size.width = CGFloat(Int(screenSize.width) - labelWidth)
            timeLabel.frame.origin.x = 10
            
        
            timeLine.backgroundColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.2666666667, alpha: 1)
            timeLine.layer.zPosition = 10
            taskScrollView.addSubview(timeLine)
            taskScrollView.addSubview(timeLabel)
        
            for object in self.timeLabels {
                object.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
                if (self.timeLabel.frame.intersects(object.frame)) {
                    object.textColor = #colorLiteral(red: 1, green: 0.2549019608, blue: 0.4117647059, alpha: 0)
                }
            
            }
        } else {
            for subview in taskScrollView.subviews {
                if subview == timeLine {
                    subview.removeFromSuperview()
                }
                if subview == timeLabel {
                    subview.removeFromSuperview()
                }
            }
        }
        
        checkTime()
    }
    
    
    @objc func checkTime() {
        if day == today {
        UIView.animate(withDuration: 0.1) {
            let hour = Calendar.current.component(.hour, from: Date())
            let minute = Calendar.current.component(.minute, from: Date())
            let currentMinutes:Double = Double(hour*60) + Double(minute)
            let currentHours:Double = Double(currentMinutes / 60)
            print(currentHours)
                    
            let labelWidth = Int(screenSize.width/10)
            let labelY = currentHours * Double(Int(screenSize.height * 1.2 / 24))
            self.timeLabel.text = "\((currentHours * 60).toHrs)"
            self.timeLabel.frame.origin.y = CGFloat(labelY)
            self.timeLine.frame.origin.y = CGFloat(CGFloat(labelY) + (self.timeLabel.frame.size.height / 2))
            
            for object in self.timeLabels {
                object.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                if (self.timeLabel.frame.intersects(object.frame)) {
                    object.textColor = #colorLiteral(red: 1, green: 0.2549019608, blue: 0.4117647059, alpha: 0)
                }
            }
            }
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
            }
        }
    }
    
    //
    // Sort Tasks
    //
    
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
    
    //
    // Refresh Table View
    //
    func setupView() {
        btnDayDict = [monday : mondayBtn, tuesday: tuesdayBtn, wednesday
            : wednesdayBtn, thursday: thursdayBtn, friday: fridayBtn, saturday: saturdayBtn, sunday: sundayBtn]
        dayBtnDict = [ mondayBtn : monday, tuesdayBtn : tuesday,
                       wednesdayBtn : wednesday, thursdayBtn : thursday, fridayBtn : friday, saturdayBtn : saturday,  sundayBtn : sunday]
        //get today
        let format = DateFormatter()
        let dayComponents = DateComponents(year: now.year , month: now.month, day: now.day)
        let date = Calendar.current.date(from: dayComponents)!
        format.dateFormat = "EEEE"
        let formattedDate = format.string(from: date)
        today = formattedDate
        var todayBtn:UIButton = mondayBtn
        todayBtn = btnDayDict[today]!
        dayBtnDict.updateValue("Today", forKey: todayBtn as! weekBtn)
        
        let dayComponents2 = DateComponents(year: now.year , month: now.month, day: now.day! + 1)
        let date2 = Calendar.current.date(from: dayComponents2)!
        let formattedDate2 = format.string(from: date2)
        tommorow = formattedDate2
        var tommorowBtn:UIButton = mondayBtn
        tommorowBtn = btnDayDict[tommorow]!
        dayBtnDict.updateValue("Tommorow", forKey: tommorowBtn as! weekBtn)
        
        
        todayBtn.sendActions(for: .touchUpInside)
    }
    
    
    func automaticRefreshView() {
        for subview in mainView.subviews {
            subview.removeFromSuperview()
        }
        
        setupScrollView()
        
        setupTimeLine()
        
        mainView.frame = CGRect(x: screenSize.width/7.5, y: 0 , width: screenSize.width - (screenSize.width/7.5) - 4, height: taskScrollView.contentSize.height)
        mainView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        taskScrollView.addSubview(mainView)
        viewTaskDict = [:]
        
        let x: CGFloat = 0
        let width: CGFloat = mainView.frame.width - 8
        
        guard let currentTasks = tasksDayDict[day] else { return }
        
            if currentTasks.count > 0 {
                for i in 0..<currentTasks.count{
                    
                    let y: CGFloat = ((((CGFloat(lastY - firstY) / 1440) * CGFloat(currentTasks[i].taskStartTime)) + CGFloat(firstY)) )
                    let height: CGFloat = ((CGFloat(lastY - firstY) / 1440) * CGFloat(currentTasks[i].taskEndTime - currentTasks[i].taskStartTime))
                    print(mainView.frame.height)
                    print(CGFloat(lastY))
                    print("zing zing")
                    print(y)
                    print(height)
                    let duration = Int(currentTasks[i].taskStartTime - currentTasks[i].taskEndTime).toFormalHrs
                    let taskView = UIView()
                    let taskNameLbl = UILabel()
                    let button = UIButton(type: .custom)
                    let sideView = UIView()
                    let durationLbl = UILabel()
                    let emojiLabel = UILabel()
                    
                    gesture = UITapGestureRecognizer(target: self, action:  #selector(taskElementPressed))
                    
                    taskView.frame = CGRect(x: x, y : y + 2, width: width - 16 , height: height)
                    taskView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    
                    let taskNameLblHeight = 22
                    let emojiLabelWH = 22
                    
                    if height > CGFloat(taskNameLblHeight * 2) {
                        //Big task Size
                         taskNameLbl.frame = CGRect(x: 13 + emojiLabelWH, y: 5, width: Int(width-40), height: taskNameLblHeight)
                         taskNameLbl.text = currentTasks[i].taskName
                         taskNameLbl.font = UIFont(name: "Quicksand-SemiBold", size: 20)
                         taskNameLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                         taskNameLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                         taskNameLbl.textAlignment = NSTextAlignment.left
                         
                        emojiLabel.frame = CGRect(x: 10, y: 5, width: emojiLabelWH, height: emojiLabelWH)
                        emojiLabel.text = currentTasks[i].taskEmoji
                        emojiLabel.font = UIFont(name: "Quicksand-SemiBold", size: 15)
                        emojiLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                        emojiLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        emojiLabel.textAlignment = NSTextAlignment.center
                         
                         durationLbl.frame = CGRect(x: 10, y: 5 + taskNameLblHeight, width: Int(width-40), height: taskNameLblHeight)
                         durationLbl.text = duration
                         durationLbl.font = UIFont(name: "Quicksand-SemiBold", size: 10)
                         durationLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                         durationLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                         durationLbl.textAlignment = NSTextAlignment.left
                         
                        button.frame = CGRect(x: 0, y: 0, width: width + 2, height: height - 4)
                        button.layer.cornerRadius = 5
                         
                         sideView.frame = CGRect(x: x, y: 0, width: 6, height: height - 4)
                         
                        if currentTasks[i].color == -1 {
                            sideView.backgroundColor = darkerColor2
                        } else {
                            sideView.backgroundColor = colors[Int(currentTasks[i].color)]
                        }
                        
                        
                        if currentTasks[i].taskIsPermanent == true {
                            if currentTasks[i].color == -1 {
                                button.backgroundColor = darkerColor2
                            } else {
                                button.backgroundColor = colors[Int(currentTasks[i].color)]
                            }
                        } else {
                            if currentTasks[i].color == -1 {
                                button.backgroundColor = darkerColor2.withAlphaComponent(0.5)
                            } else {
                                button.backgroundColor = colors[Int(currentTasks[i].color)].withAlphaComponent(0.5)
                            }
                        }
                         
                         button.addTarget(self, action:  #selector(taskElementPressed), for: .touchUpInside)
                         viewTaskDict[taskView] = currentTasks[i]
                         
                         
                         mainView.addSubview(taskView)
                         taskView.addSubview(button)
                        taskView.addSubview(sideView)
               
                         taskView.addSubview(taskNameLbl)
                         taskView.addSubview(emojiLabel)
                         taskView.addSubview(durationLbl)
                    } else if height > CGFloat(taskNameLblHeight) {
                        //just emoji
                         
                        emojiLabel.frame = CGRect(x: 10, y: 5, width: emojiLabelWH, height: emojiLabelWH)
                        emojiLabel.text = currentTasks[i].taskEmoji
                        emojiLabel.font = UIFont(name: "Quicksand-SemiBold", size: 15)
                        emojiLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                        emojiLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        emojiLabel.textAlignment = NSTextAlignment.center
                         
                         button.frame = CGRect(x: 0, y: 0, width: width, height: height)
                         
                         sideView.frame = CGRect(x: x, y: 0, width: 5, height: height)
                         sideView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.04705882353)
                         
                         if currentTasks[i].taskIsPermanent == true {
                             if currentTasks[i].color == -1 {
                                 button.backgroundColor = darkerColor2
                             } else {
                                 button.backgroundColor = colors[Int(currentTasks[i].color)]
                             }
                         } else {
                             if currentTasks[i].color == -1 {
                                 button.backgroundColor = darkerColor2.withAlphaComponent(0.7)
                             } else {
                                 button.backgroundColor = colors[Int(currentTasks[i].color)].withAlphaComponent(0.7)
                             }
                         }
                         
                         button.addTarget(self, action:  #selector(taskElementPressed), for: .touchUpInside)
                        button.layer.cornerRadius = 5
                         viewTaskDict[taskView] = currentTasks[i]
                         
                         
                         mainView.addSubview(taskView)
                         taskView.addSubview(button)
                         taskView.addSubview(emojiLabel)
                         
                    } else  {
                        //nothing
                        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
                        
                        sideView.frame = CGRect(x: x, y: 0, width: 5, height: height)
                        sideView.backgroundColor = mainColor
                        
                        if currentTasks[i].taskIsPermanent == true {
                            if currentTasks[i].color == -1 {
                                button.backgroundColor = darkerColor2
                            } else {
                                button.backgroundColor = colors[Int(currentTasks[i].color)]
                            }
                        } else {
                            if currentTasks[i].color == -1 {
                                button.backgroundColor = darkerColor2.withAlphaComponent(0.7)
                            } else {
                                button.backgroundColor = colors[Int(currentTasks[i].color)].withAlphaComponent(0.7)
                            }
                        }
                        
                        button.layer.cornerRadius = height / 2
                        
                        button.addTarget(self, action:  #selector(taskElementPressed), for: .touchUpInside)
                        viewTaskDict[taskView] = currentTasks[i]
                        
                        
                        mainView.addSubview(taskView)
                        taskView.addSubview(button)

                    }
                    

                }
            }
        
    }
    

    
    
    @objc func taskElementPressed(sender: UIButton){
        var clickedView = viewTaskDict[sender.superview!]
        print(clickedView)
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "TaskDetailsVC") as! TaskDetailsVC
        detailsVC.task = clickedView
        present(detailsVC, animated: true, completion: nil)
    }

 


    //
    // Segues and Movement
    //
    @IBAction func addTaskBtnWasPressed(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "PreCreateTaskVC") as! PreCreateTaskVC
        emojiBtnText = "🦆"
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated:true, completion: nil)
    }
    
    @IBAction func notesTaskSwitch(_ sender: Any) {
        if isTaskFront == true {
            isTaskFront = false
        } else {
            isTaskFront = true
        }
    }
    
    
    //
    //  Notifications
    //
    func sendNotification(title: String, subtitle: String, body:String, badge: Int?, delayInterval: Int?) {
       
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        
        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
        
        if let delayInterval = delayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
        }
        
        if let badge = badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            content.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription)
        }
        
        
//        let date = Date().addingTimeInterval(5)
//        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//
//        center.add(request) { (error) in
//
//        }
        
    }
    
    //
    // Week Buttons
    //
    func btnCheck(_ button: weekBtn) {
        mondayBtn.unselectedMain()
        tuesdayBtn.unselectedMain()
        wednesdayBtn.unselectedMain()
        thursdayBtn.unselectedMain()
        fridayBtn.unselectedMain()
        saturdayBtn.unselectedMain()
        sundayBtn.unselectedMain()
        
        if today == monday {
            mondayBtn.today()
        } else if today == tuesday {
            tuesdayBtn.today()
        } else if today == wednesday {
            wednesdayBtn.today()
        } else if today == thursday {
            thursdayBtn.today()
        } else if today == friday {
            fridayBtn.today()
        } else if today == saturday {
            saturdayBtn.today()
        } else if today == sunday {
            sundayBtn.today()
        }
        
        
        button.selectedMain()
        
        
        let format = DateFormatter()
        format.dateFormat = "MMM d"
        let formattedDate = format.string(from: theDay()!)
        monthLbl.text = formattedDate

    }
    
    func theDay() -> Date? {
        let format = DateFormatter()
        var dater:Date? = nil
        
        for i in 0...6 {
            let dayComponents = DateComponents(year: now.year , month: now.month, day: now.day! + i)
            let date = Calendar.current.date(from: dayComponents)!
            format.dateFormat = "EEEE"
            let formattedDate = format.string(from: date)
            
            if formattedDate == day {
                dater = date
            }
            
            if i == 0 {
                today = formattedDate
                
            }
            
        }
        return dater

    }
    
    


    @IBAction func mondayBtnPressed(_ sender: UIButton) {
        impact.prepare()
        impact.impactOccurred()
        day = monday
        weekLbl.text = dayBtnDict[mondayBtn]
        btnCheck(mondayBtn)
        automaticRefreshView()
    }
    @IBAction func tuesdayBtnPressed(_ sender: UIButton) {
        impact.impactOccurred()
        day = tuesday
        weekLbl.text = dayBtnDict[tuesdayBtn]
        btnCheck(tuesdayBtn)
        automaticRefreshView()
    }
    @IBAction func wednesdayBtnPressed(_ sender: UIButton) {
        impact.impactOccurred()
        day = wednesday
        weekLbl.text = dayBtnDict[wednesdayBtn]
        btnCheck(wednesdayBtn)
        automaticRefreshView()
    }
    @IBAction func thursdayBtnPressed(_ sender: UIButton) {
        impact.impactOccurred()
        day = thursday
        weekLbl.text = dayBtnDict[thursdayBtn]
        btnCheck(thursdayBtn)
        automaticRefreshView()
    }
    @IBAction func fridayBtnPressed(_ sender: UIButton) {
        impact.impactOccurred()
        day = friday
        weekLbl.text = dayBtnDict[fridayBtn]
        btnCheck(fridayBtn)
        automaticRefreshView()
    }
    @IBAction func saturdayBtnPressed(_ sender: UIButton) {
        impact.impactOccurred()
        day = saturday
        weekLbl.text = dayBtnDict[saturdayBtn]
        btnCheck(saturdayBtn)
        automaticRefreshView()
    }
    @IBAction func sundayBtnPressed(_ sender: UIButton) {
        impact.impactOccurred()
        day = sunday
        weekLbl.text = dayBtnDict[sundayBtn]
        btnCheck(sundayBtn)
        automaticRefreshView()
    }
    
}

////////////////////////////////////////////////////////////
/////////////////////// EXTENSTIONS ////////////////////////
////////////////////////////////////////////////////////////

extension TaskVC: UIScrollViewDelegate {
    
    func setupScrollView() {
    
        let viewHeight =  screenSize.height * CGFloat(1.2)
        for i in 0...24 {
            
            let label = UILabel()
            let line = UIView()
            
            let labelWidth = Int(screenSize.width/10)
            let labelY = i * Int(screenSize.height * 1.2 / 24)
            
            label.frame = CGRect(x: 0, y: labelY , width: labelWidth , height: 20)
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textAlignment = .right
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = "\((i * 60).toHrs)"
            
            label.font = UIFont(name: "Quicksand-SemiBold", size: 12)
            
            
            
            if i == 24 {
                label.text = "\((0).toHrs)"
            } else {
                label.text = "\((i * 60).toHrs)"
            }
            
            label.sizeToFit()
            label.frame.size.width = CGFloat(labelWidth)
            
            line.frame = CGRect(x: label.frame.maxX + 10, y: CGFloat(labelY) + (label.frame.height/2), width: CGFloat(Int(screenSize.width) - labelWidth), height: CGFloat(1))
            
                
            line.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            timeLabels.append(label)
            self.taskScrollView.addSubview(label)
            self.taskScrollView.addSubview(line)
            
            if i == 0 {
                firstY = Int(CGFloat(labelY) + (label.frame.height/2) + 1)
                print("HEKADSHLFKASF")
                print(firstY)
            }
            
            if i == 24 {
                lastY = Int(CGFloat(labelY) + (label.frame.height/2) + 1)
                print("THIS IS LASTY:")
                print(lastY)
            }
            
        }
        
        self.taskScrollView.contentSize = CGSize(width: screenSize.width, height: viewHeight)
    }
}
    
        
extension TaskVC {
    
    func fetch(completion: (_ complete: Bool) ->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.returnsObjectsAsFaults = false

        
        do  {
            tasks = try managedContext.fetch(fetchRequest)
            
            completion(true)
            print("sucessfully fetched data")
            
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}

extension TaskVC: UNUserNotificationCenterDelegate {
    
}




