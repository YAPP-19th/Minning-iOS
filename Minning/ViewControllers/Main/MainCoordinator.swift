//
//  MainCoordinator.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import DesignSystem
import Foundation

protocol MainRoute {
    
}

class MainCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: MainDIContainer
    private let coordinator: AppCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: MainDIContainer,
         coordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start(asRoot: Bool = false) {
        let mainTabVC = dependencies.createMainTab(self)
        if asRoot {
            navigationController.setViewControllers([mainTabVC], animated: false)
        } else {
            navigationController.pushViewController(mainTabVC, animated: false)
        }
    }
}

extension MainCoordinator: MainRoute {
    
}
