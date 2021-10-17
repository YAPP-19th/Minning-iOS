//
//  RoutineViewModel.swift
//  Minning
//
//  Created by 고세림 on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

final class RoutineViewModel {
    enum RoutineTabType {
        case routine
        case review
    }
    
    var tabType: RoutineTabType = .routine
}
