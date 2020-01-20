//
//  CalendarVC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 19/01/2020.
//  Copyright © 2020 Martin Michalko. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func configureCell(view: JTAppleCell?, cellState: CellState) {
       guard let cell = view as? CalendarCell  else { return }
       cell.dateLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
           cell.isHidden = false
        } else {
           cell.isHidden = true
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        let bottomOffset = CGPoint(x: 0, y: calendarView.contentSize.height - calendarView.bounds.size.height)
        calendarView.setContentOffset(bottomOffset, animated: false)
    }

    
    
    //
    // HEADER View
    //
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMMM yyyy"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "CalendarHeader", for: indexPath) as! CalendarHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }

    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    

}

extension CalendarVC: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension CalendarVC: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
}


