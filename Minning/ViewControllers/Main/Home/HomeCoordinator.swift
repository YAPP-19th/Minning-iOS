//
//  HomeCoordinator.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol HomeRoute {
    func goToPhrase()
}

class HomeCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: HomeDIContainer
    private let coordinator: MainCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: HomeDIContainer,
         coordinator: MainCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: coordinator)
        let homeVC = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeVC], animated: false)
    }
}

extension HomeCoordinator: HomeRoute {
    func goToPhrase() {
        let _ = dependencies.createPhrase(self)
    }
}
