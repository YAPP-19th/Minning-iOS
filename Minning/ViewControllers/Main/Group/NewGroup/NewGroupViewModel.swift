//
//  NewGroupViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/04.
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
