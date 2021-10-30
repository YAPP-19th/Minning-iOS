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
    func goToAuthHome()
    func goToPassword(animated: Bool, isLogin: Bool)
    func goToMain(asRoot: Bool)
    func goToNickname(animated: Bool)
    func goToFindPassword()
    func goToEmailAuth()
    func goToNewPassword()
    func goToBack()
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
}

extension AuthCoordinator: AuthRoute {
    func goToAuthHome() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToPassword(animated: Bool = false, isLogin: Bool) {
        let passwordVC = dependencies.createPassword(self, isLogin: isLogin)
        navigationController.pushViewController(passwordVC, animated: animated)
    }
    
    func goToMain(asRoot: Bool = false) {
        coordinator.gotoMain(asRoot: asRoot)
    }
    
    func goToNickname(animated: Bool = false) {
        let nicknameVC = dependencies.createNickname(self)
        navigationController.pushViewController(nicknameVC, animated: animated)
    }
    
    func goToFindPassword() {
        let findPwVC = dependencies.createFindPassword(self)
        navigationController.pushViewController(findPwVC, animated: true)
    }
    
    func goToEmailAuth() {
        let emailAuthVC = dependencies.createEmailAuth(self)
        navigationController.pushViewController(emailAuthVC, animated: true)
    }
    
    func goToNewPassword() {
        let newPasswordVC = dependencies.createNewPassword(self)
        navigationController.pushViewController(newPasswordVC, animated: true)
    }
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
}
