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
    var isOrderEdited: DataBinding<Bool> = DataBinding(false)
    
    init(coordinator: HomeCoordinator, day: Day, routineList: [RoutineModel]) {
        self.coordinator = coordinator
        self.day = day
        self.routineList = routineList
    }
    
    public func patchRoutineSequence(completion: @escaping () -> Void) {
        let routineIdList = routineList.map { $0.id }
        RoutineAPIRequest.modifyRoutineOrderByDay(day: day, routineIds: routineIdList) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                DebugLog(error.localizedDescription)
            }
        }
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
