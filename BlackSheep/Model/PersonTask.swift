//
//  PeopleTasks.swift
//  BlackSheep
//
//  Created by Martin Michalko on 27/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import Foundation

struct PersonTask {
    private(set) public var personName: String
    private(set) public var imageName: String
    
    init(personName: String, imageName: String) {
        self.personName = personName
        self.imageName = imageName
    }
}
