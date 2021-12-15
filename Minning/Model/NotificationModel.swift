//
//  NotificationModel.swift
//  Minning
//
//  Created by denny on 2021/10/05.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public struct NotificationModel {
    let title: String
    let description: String
    let date: Date
    
    enum Category {
        case routineAlert
        case groupAlert
        case groupEnded
        case weekReport
        case monthReport
        case longtimeNoSee
    }
    
}
