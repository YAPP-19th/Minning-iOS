//
//  AppCoordinator.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import DesignSystem
import Foundation

protocol AppRoute {
    func gotoSplash()
    func gotoMain()
    func start()
}

class AppCoordinator {
    var navigationController: UINavigationController
    
    private let appDIContainer: AppDIContainer
    lazy var appConfiguration = AppConfiguration()
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        navigationController.popToRootViewController(animated: false)
        
        // Other Auth Check (Token etc...)
    }
}

extension AppCoordinator: AppRoute {
    func gotoSplash() {
        let splash = appDIContainer.createSplash(coordinator: self)
        navigationController.pushViewController(splash, animated: false)
    }
    
    func gotoMain() {
        let mainID = MainDIContainer()
        let coordinator = MainCoordinator(navigationController: navigationController,
                                          dependencies: mainID,
                                          coordinator: self)
        coordinator.start()
    }
}
