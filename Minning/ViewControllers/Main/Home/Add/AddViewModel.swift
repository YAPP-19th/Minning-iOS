//
//  AddViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class AddViewModel {
    let coordinator: HomeCoordinator
    
    var routineId: Int64?
    var title: String?
    var goal: String?
    var selectedCategoryIndex: Int?
    var selectedDays = [Day]()
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public func postAddRoutine(title: String, goal: String, category: RoutineCategory, days: [Day], completion: @escaping () -> Void) {
        RoutineAPIRequest.addRoutine(request: .init(category: category, days: days, goal: goal, startTime: "00:00", title: title)) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                DebugLog(error.localizedDescription)
            }
        }
    }
    
    public func patchModifyRoutine(title: String, goal: String, category: RoutineCategory, days: [Day], completion: @escaping () -> Void) {
        guard let id = routineId else { return }
        RoutineAPIRequest.modifyRoutine(routineId: id, request: .init(category: category, days: days, goal: goal, startTime: "00:00", title: title)) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                DebugLog(error.localizedDescription)
            }
        }
    }
    
    public func deleteRoutine() {
        guard let id = routineId else { return }
        RoutineAPIRequest.deleteRoutine(routineId: id) { [weak self] result in
            switch result {
            case .success(_):
                self?.goToBack()
            case .failure(let error):
                DebugLog(error.localizedDescription)
            }
        }
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
