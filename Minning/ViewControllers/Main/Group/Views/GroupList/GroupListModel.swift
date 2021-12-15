//
//  GroupListModel.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/12.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

class GroupListModel {
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
    let participant: String
    
    init(category: Category, title: String, percentage: String, participant: String) {
        self.category = category
        self.title = title
        self.percentage = percentage
        self.participant = participant
    }

}