//
//  MyGroupCategoryModel.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

class MyGroupCategoryModel { 
    enum Category {
        case miracleMorning
        case selfImprovement
        case health
        case life
        case wakeupTime
    }
    
    let category: Category
    let title: String
    let percentage: String
    let day: String
    let dayLeft: String
    
    init(category: Category, title: String, percentage: String, day: String, dayLeft: String) {
        self.category = category
        self.title = title
        self.percentage = percentage
        self.day = day
        self.dayLeft = dayLeft
    }

}
