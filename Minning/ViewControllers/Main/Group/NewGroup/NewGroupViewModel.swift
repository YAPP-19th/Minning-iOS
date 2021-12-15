//
//  NewGroupViewModel.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/16.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class NewGroupViewModel {
    private let coordinator: GroupCoordinator
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToBack() {
        coordinator.goToBack()
    }
}
