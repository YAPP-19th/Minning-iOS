//
//  EditOrderViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class EditOrderViewModel {
    let coordinator: HomeCoordinator
    var day: Day
    var routineList: [RoutineModel]
    var isOrderEdited: Bool = false
    
    init(coordinator: HomeCoordinator, day: Day, routineList: [RoutineModel]) {
        self.coordinator = coordinator
        self.day = day
        self.routineList = routineList
    }
    
    public func patchRoutineSequence() {
        let routineIdList = routineList.map { $0.id }
        RoutineAPIRequest.modifyRoutineOrderByDay(day: day, routineIds: routineIdList) { [weak self] result in
            switch result {
            case .success(_):
                self?.isOrderEdited = true
            case .failure(let error):
                DebugLog(error.localizedDescription)
            }
        }
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
