//
//  AuthDIContainer.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

final class AuthDIContainer {
    func createLogin(_ coordinator: AuthCoordinator) -> LoginViewController {
        let viewModel = LoginViewModel(coordinator: coordinator)
        let vc = LoginViewController(viewModel: viewModel)
        return vc
    }
    
    func createPassword(_ coordinator: AuthCoordinator, isLogin: Bool) -> PasswordViewController {
        let viewModel = PasswordViewModel(coordinator: coordinator, passwordViewType: isLogin ? .login : .signUp)
        let vc = PasswordViewController(viewModel: viewModel)
        return vc
    }
    
    func createNickname(_ coordinator: AuthCoordinator) -> NicknameViewController {
        let viewModel = NicknameViewModel(coordinator: coordinator)
        let vc = NicknameViewController(viewModel: viewModel)
        return vc
    }
}
