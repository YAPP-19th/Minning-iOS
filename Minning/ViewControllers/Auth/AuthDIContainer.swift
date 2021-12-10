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
    
    func createPassword(_ coordinator: AuthCoordinator, isLogin: Bool, email: String) -> PasswordViewController {
        let viewModel = PasswordViewModel(coordinator: coordinator, passwordViewType: isLogin ? .login : .signUp, email: email)
        let vc = PasswordViewController(viewModel: viewModel)
        return vc
    }
    
    func createNickname(_ coordinator: AuthCoordinator,
                        email: String?, password: String?, socialToken: String?, isSocial: Bool, socialType: SocialType?) -> NicknameViewController {
        let viewModel = NicknameViewModel(coordinator: coordinator,
                                          email: email, password: password,
                                          isSocial: isSocial, socialType: socialType, token: socialToken)
        let vc = NicknameViewController(viewModel: viewModel)
        return vc
    }
    
    func createFindPassword(_ coordinator: AuthCoordinator) -> FindPasswordViewController {
        let viewModel = FindPasswordViewModel(coordinator: coordinator)
        let vc = FindPasswordViewController(viewModel: viewModel)
        return vc
    }
    
    func createEmailAuth(_ coordinator: AuthCoordinator) -> EmailAuthViewController {
        let viewModel = EmailAuthViewModel(coordinator: coordinator)
        let vc = EmailAuthViewController(viewModel: viewModel)
        return vc
    }
    
    func createNewPassword(_ coordinator: AuthCoordinator) -> NewPasswordViewController {
        let viewModel = NewPasswordViewModel(coordinator: coordinator)
        let vc = NewPasswordViewController(viewModel: viewModel)
        return vc
    }
}
