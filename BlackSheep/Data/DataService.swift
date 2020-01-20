//
//  PeopleTasksData.swift
//  BlackSheep
//
//  Created by Martin Michalko on 27/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let peopleTasksData = [
        PersonTask(personName: "Elon Musk", imageName: ""),
        PersonTask(personName: "LeBron James", imageName: ""),
        PersonTask(personName: "Arnold Swartzeneger", imageName: ""),
        PersonTask(personName: "Mark Cuban", imageName: ""),
        PersonTask(personName: "Aaron Paul", imageName: ""),
    ]
    
    func getPeopleTasks() -> [PersonTask] {
        return peopleTasksData
    }
}
