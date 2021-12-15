//
//  GroupModel.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import UIKit

public struct Group {
    let title: String
}

public struct MyGroup {
    let myAchieveRate: Int
    let groupDate: String
    let dayLeft: Int
}

public struct GroupList {
    let achieveRate: Int
    let participant: Int
}

//public struct GroupInfo {
//    let title: String
//    let color: UIColor
//    let icon: UIImage
//    let certified: UIImage
//}
public enum GroupInfo: Int, CaseIterable {
    // 미라클모닝, 기상, 자기개발, 건강, 공부
    case miracle = 0
    case wakeup
    case selfImprovement
    case health
    case study
    
    var color: UIColor {
        switch self {
        case .miracle:
            return .cateGreen100
        case .wakeup:
            return .cateYellow100
        case .selfImprovement:
            return .cateRed100
        case .health:
            return .cateSky100
        case .study:
            return .catePurple100
        }
    }
    
    
}
