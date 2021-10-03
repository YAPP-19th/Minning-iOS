//
//  ReportViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class ReportViewModel {
    enum ReportTabType {
        case week
        case month
    }
    
    var tabType: DataBinding<ReportTabType> = DataBinding(.week)
    private let coordinator: MainCoordinator
    
    public init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}
