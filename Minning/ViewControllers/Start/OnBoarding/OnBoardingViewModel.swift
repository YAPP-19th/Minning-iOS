//
//  OnBoardingViewModel.swift
//  Minning
//
//  Created by denny on 2021/12/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

final class OnBoardingViewModel {
    private let coordinator: StartCoordinator
    
    public init(coordinator: StartCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToMain() {
        coordinator.gotoMain()
    }
    
    func goToLogin() {
        coordinator.gotoLogin(asRoot: true)
    }
}
