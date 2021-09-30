//
//  PasswordViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

final class PasswordViewModel {
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToMain() {
        coordinator.goToMain(asRoot: true)
    }
}
