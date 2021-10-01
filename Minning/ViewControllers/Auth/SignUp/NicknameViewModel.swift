//
//  NicknameViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

final class NicknameViewModel {
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToMain() {
        coordinator.goToMain(asRoot: true)
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
