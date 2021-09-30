//
//  AuthCoordinator.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol AuthRoute {
    
}

class AuthCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: AuthDIContainer
    private let coordinator: AppCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: AuthDIContainer,
         coordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start(asRoot: Bool = false) {
        let loginVC = dependencies.createLogin(self)
        if asRoot {
            navigationController.setViewControllers([loginVC], animated: false)
        } else {
            navigationController.pushViewController(loginVC, animated: false)
        }
    }
    
    func goToPassword(animated: Bool = false) {
        let passwordVC = dependencies.createPassword(self)
        navigationController.pushViewController(passwordVC, animated: animated)
    }
}

extension AuthCoordinator: AuthRoute {
    
}
