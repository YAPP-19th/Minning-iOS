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
    
    var selectedCategoryIndex: Int?
    var selectedDays = [Day]()
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public func postAddRoutine(title: String, goal: String, category: RoutineCategory, days: [Day], time: String, completion: @escaping () -> Void) {
        RoutineAPIRequest.addRoutine(request: .init(category: category, days: days, goal: goal, startTime: time, title: title)) { result in
            switch result {
            case .success(let data):
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
