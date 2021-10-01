//
//  PasswordViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class PasswordViewModel {
    public enum PasswordViewType {
        case login
        case signUp
        
        var title: String {
            switch self {
            case .login:
                return "로그인"
            case .signUp:
                return "회원가입"
            }
        }
        
        var buttonContent: String {
            switch self {
            case .login:
                return "로그인"
            case .signUp:
                return "계속하기"
            }
        }
        
        var textFieldHint: String {
            switch self {
            case .login:
                return "비밀번호를 입력해주세요"
            case .signUp:
                return "8자리 이상의 비밀번호가 필요합니다"
            }
        }
    }
    
    private let coordinator: AuthCoordinator
    public var passwordViewType: DataBinding<PasswordViewType> = DataBinding(.login)
    
    public init(coordinator: AuthCoordinator, passwordViewType: PasswordViewType) {
        self.coordinator = coordinator
        self.passwordViewType.accept(passwordViewType)
    }
    
    public func goToMain() {
        coordinator.goToMain(asRoot: true)
    }
    
    public func goToNickname() {
        coordinator.goToNickname(animated: true)
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
