//
//  SplashViewModel.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

final class SplashViewModel {
    private let coordinator: AppCoordinator
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToMain() {
        coordinator.gotoMain()
    }
    
    func goToLogin() {
//        coordinator.gotoLogin(asRoot: true)
        coordinator.gotoMain()
    }
}
