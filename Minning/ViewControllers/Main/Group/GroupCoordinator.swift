//
//  GroupCoordinator.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol GroupRoute {
}

class GroupCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: GroupDIContainer
    private let coordinator: MainCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: GroupDIContainer,
         coordinator: MainCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start() {
        let viewModel = GroupViewModel(coordinator: coordinator)
        let reportVC = GroupViewController(viewModel: viewModel)
        navigationController.setViewControllers([reportVC], animated: false)
    }
}

extension GroupCoordinator: GroupRoute {
    
}
