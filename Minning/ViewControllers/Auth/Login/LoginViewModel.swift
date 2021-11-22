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
    
    private let coordinator: AuthCoordinator
    
    public init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToPassword(isLogin: Bool) {
        coordinator.goToPassword(animated: true, isLogin: isLogin, email: emailValue.value)
    }
}
