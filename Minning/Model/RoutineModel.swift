//
//  RoutineModel.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

public enum RoutineCategory {
    // 운동, 생활, 학습, 미라클모닝, 기타
    case exercise
    case life
    case study
    case miracle
    case other
    
    var color: UIColor {
        switch self {
        case .exercise:
            return .routineBlue
        case .life:
            return .routineGreen
        case .study:
            return .routinePurple
        case .miracle:
            return .routineGreen
        case .other:
            return .routineYellow
        }
    }
}

public struct Routine {
    let title: String
    let category: RoutineCategory
}
