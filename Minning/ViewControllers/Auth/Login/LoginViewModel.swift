//
//  LoginViewModel.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import Combine
import Foundation
import CommonSystem

final class LoginViewModel: ObservableObject {
    public var emailValue: DataBinding<String> = DataBinding("")
    public var passwordValue: DataBinding<String> = DataBinding("")
    public var socialType: DataBinding<SocialType> = DataBinding(.email)
    
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToPassword(isLogin: Bool) {
        coordinator.goToPassword(animated: true, isLogin: isLogin)
    }
    
    public func doLogin() {
        let loginRequest = LoginRequest(email: emailValue.value, password: passwordValue.value, socialType: socialType.value)
        AuthAPIRequest.login(request: loginRequest, completion: { result in
            
        })
    }
}
