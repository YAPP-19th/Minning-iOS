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
    func gotoMain(asRoot: Bool)
    func gotoLogin(asRoot: Bool)
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
    
    func gotoOnBoarding() {
        let startDI = StartDIContainer()
        let coordinator = StartCoordinator(navigationController: navigationController,
                                           dependencies: startDI,
                                           coordinator: self)
        coordinator.start()
    }
    
    func gotoMain(asRoot: Bool = false) {
        let mainID = MainDIContainer()
        let coordinator = MainCoordinator(navigationController: navigationController,
                                          dependencies: mainID,
                                          coordinator: self)
        coordinator.start(asRoot: asRoot)
    }
    
    func gotoLogin(asRoot: Bool = false) {
        let loginID = AuthDIContainer()
        let coordinator = AuthCoordinator(navigationController: navigationController,
                                          dependencies: loginID,
                                          coordinator: self)
        coordinator.start(asRoot: asRoot)
    }
}
