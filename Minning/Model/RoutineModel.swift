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
    // 운동, 생활, 자기개발, 미라클모닝
    case exercise
    case life
    case selfDev
    case miracle
    case other
    
    var color: UIColor {
        switch self {
        case .exercise:
            return .cateGreen100
        case .life:
            return .cateYellow100
        case .selfDev:
            return .cateRed100
        case .miracle:
            return .cateSky100
        case .other:
            return .catePurple100
        }
    }
}

public enum RoutineResult {
    case done // 다했어요
    case tried // 시도했어요
    case relax // 쉬었어요
    case failure // 못했어요
    
    var symbolOpacity: Float {
        switch self {
        case .done, .failure:
            return 1.0
        case .tried:
            return 0.5
        case .relax:
            return 0
        }
    }
    
    var symbolImage: UIImage? {
        switch self {
        case .done:
            return UIImage(sharedNamed: "routine_done")
        case .failure:
            return UIImage(sharedNamed: "routine_failure")
        case .tried:
            return UIImage(sharedNamed: "routine_tried")
        case .relax:
            return nil
        }
    }
}

public struct Routine {
    let title: String
    let category: RoutineCategory
    let result: RoutineResult
}
