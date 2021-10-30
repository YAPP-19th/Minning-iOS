//
//  NewPasswordViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

final class NewPasswordViewModel {
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
    
    public func goToLogin() {
        coordinator.start(asRoot: true)
    }
}
