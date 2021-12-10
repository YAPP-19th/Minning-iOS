//
//  StartCoordinator.swift
//  Minning
//
//  Created by denny on 2021/12/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol StartRoute {
    func gotoMain()
    
    func gotoLogin(asRoot: Bool)
}

class StartCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: StartDIContainer
    private let coordinator: AppCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: StartDIContainer,
         coordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start() {
        let onboardingVC = dependencies.createOnboarding(coordinator: self)
        navigationController.setViewControllers([onboardingVC], animated: false)
    }
}

extension StartCoordinator: StartRoute {
    func gotoLogin(asRoot: Bool) {
        coordinator.gotoLogin(asRoot: asRoot)
    }
    
    func gotoMain() {
        coordinator.gotoMain()
    }
}
