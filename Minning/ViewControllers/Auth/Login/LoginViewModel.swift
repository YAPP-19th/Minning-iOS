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
    public var emailValue: DataBinding<String> = ""
    public var passwordValue: DataBinding<String> = ""
    public var socialType: DataBinding<LoginRequest.SocialType> = .email
    
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToPassword(isLogin: Bool) {
        coordinator.goToPassword(animated: true, isLogin: isLogin)
    }
    
    public func doLogin() {
        let loginRequest = LoginRequest(email: emailValue.value, password: passwordValue.value, socialType: socialType.value)
        let authAPIRequest = AuthAPIRequest.loginByEmail(request: loginRequest)
        
        MinningRequest.perform(authAPIRequest, completion: { result in
            
        })
    }
}
