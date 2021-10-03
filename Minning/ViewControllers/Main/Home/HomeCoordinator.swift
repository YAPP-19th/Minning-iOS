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
    
    func goToRecommend()
    
    func goToAdd()
    
    func goToReview()
    
    func goToEditOrder()
    
    func goToNotification()
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
        let viewModel = HomeViewModel(coordinator: self)
        let homeVC = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeVC], animated: false)
    }
}

extension HomeCoordinator: HomeRoute {
    func goToPhrase() {
        let phraseVC = dependencies.createPhrase(self)
        navigationController.topViewController?.present(phraseVC, animated: true, completion: nil)
    }
    
    func goToRecommend() {
        let _ = dependencies.createRecommend(self)
    }
    
    func goToAdd() {
        let addVC = dependencies.createAdd(self)
        navigationController.pushViewController(addVC, animated: true)
    }
    
    func goToReview() {
        let reviewVC = dependencies.createReview(self)
        navigationController.pushViewController(reviewVC, animated: true)
    }
    
    func goToEditOrder() {
        let editVC = dependencies.createEditOrder(self)
        navigationController.pushViewController(editVC, animated: true)
    }
    
    func goToNotification() {
        let notificationVC = dependencies.createNotification(self)
        navigationController.pushViewController(notificationVC, animated: true)
    }
}
