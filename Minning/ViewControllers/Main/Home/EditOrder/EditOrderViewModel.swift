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
    var tempDataList = ["아침에 신문~", "모닝 커피", "달리기"]
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
