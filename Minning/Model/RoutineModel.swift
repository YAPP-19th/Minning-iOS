//
//  RoutineModel.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

public enum Day: String, CaseIterable {
    case sun = "SUN"
    case mon = "MON"
    case tue = "TUE"
    case wed = "WED"
    case thu = "THU"
    case fri = "FRI"
    case sat = "SAT"
    
    var korean: String {
        switch self {
        case .sun:
            return "일"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fri:
            return "금"
        case .sat:
            return "토"
        }
    }
}

public enum RoutineCategory: Int, CaseIterable {
    // 미라클모닝, 자기개발, 건강, 생활, 기타
    case miracle = 0
    case selfDev
    case health
    case life
    case other
    
    var color: UIColor {
        switch self {
        case .health:
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
    
    var title: String {
        switch self {
        case .health:
            return "건강"
        case .life:
            return "생활"
        case .selfDev:
            return "자기개발"
        case .miracle:
            return "미라클모닝"
        case .other:
            return "기타"
        }
    }
}

public enum GroupCategory: Int32, CaseIterable {
    // 미라클모닝, 자기개발, 건강, 생활, 기타
    case miracle = 0
    case selfDev
    case health
    case life
    case wakeup
    
    var color: UIColor {
        switch self {
        case .health:
            return .cateGreen100
        case .life:
            return .cateYellow100
        case .selfDev:
            return .cateRed100
        case .miracle:
            return .cateSky100
        case .wakeup:
            return .minningBlue100
        }
    }
    
    var title: String {
        switch self {
        case .health:
            return "건강"
        case .life:
            return "생활"
        case .selfDev:
            return "자기개발"
        case .miracle:
            return "미라클모닝"
        case .wakeup:
            return "기상"
        }
    }
}

public enum RoutineResult: String {
    case done = "DONE" // 다했어요
    case tried = "TRY" // 시도했어요
    case relax // 쉬었어요
    case failure = "NOT" // 못했어요
    
    var title: String {
        switch self {
        case .done:
            return "완료"
        case .tried:
            return "부분완료"
        case .relax:
            return ""
        case .failure:
            return "미완료"
        }
    }
    
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
            return UIImage(sharedNamed: "weekly_complete")
        case .tried:
            return UIImage(sharedNamed: "weekly_half")
        case .failure:
            return UIImage(sharedNamed: "weekly_incomplete")
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

public struct ReportRoutine {
    let category: RoutineCategory
    let percent: CGFloat
    let routines: [MonthlyRoutine]
}

public struct MonthlyRoutine {
    let title: String
    let donePercent: CGFloat
    let triedPercent: CGFloat
    let failurePercent: CGFloat
}
