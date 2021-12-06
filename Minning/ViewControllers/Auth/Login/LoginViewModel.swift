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
    
    public func processSocialCheck(email: String, id: Int64, socialType: SocialType, token: String) {
        let socialRequest = SocialRequest(email: email, id: id, socialType: socialType, token: token)
        AuthAPIRequest.socialCheck(request: socialRequest, completion: { result in
            switch result {
            case .success(let response):
                DebugLog("SocialCheck AccessToken : \(response.data.accessToken)")
            case .failure(let error):
                ErrorLog("Error : \(error.localizedDescription)")
            }
        })
    }
}
