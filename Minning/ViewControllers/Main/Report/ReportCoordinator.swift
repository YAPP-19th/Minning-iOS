//
//  ReportCoordinator.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol ReportRoute {
    func goToBack()
}

class ReportCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: ReportDIContainer
    private let coordinator: MainCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: ReportDIContainer,
         coordinator: MainCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start() {
        let viewModel = ReportViewModel(coordinator: coordinator)
        let reportVC = ReportViewController(viewModel: viewModel)
        navigationController.setViewControllers([reportVC], animated: false)
    }
}

extension ReportCoordinator: ReportRoute {
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
}
