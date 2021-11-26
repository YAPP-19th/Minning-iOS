//
//  LoginViewModel.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class LoginViewModel: ObservableObject {
    public var emailValue: DataBinding<String?> = DataBinding(nil)
    
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToPassword(isLogin: Bool) {
        if let email = emailValue.value {
            coordinator.goToPassword(animated: true, isLogin: isLogin, email: email)
        } else {
            ErrorLog("Email을 입력해주세요")
        }
    }
}
