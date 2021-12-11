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
    
    public let emailValue: String
    public var passwordValue: DataBinding<String?> = DataBinding(nil)
    public var socialType: DataBinding<SocialType> = DataBinding(.email)
    public var passwordViewType: DataBinding<PasswordViewType> = DataBinding(.login)
    
    public init(coordinator: AuthCoordinator, passwordViewType: PasswordViewType, email: String) {
        self.coordinator = coordinator
        self.emailValue = email
        self.passwordViewType.accept(passwordViewType)
    }
    
    public func goToMain() {
        coordinator.goToMain(asRoot: true)
    }
    
    public func goToNickname() {
        coordinator.goToNickname(animated: true, email: emailValue, password: passwordValue.value)
    }
    
    public func goToFindPassword() {
        coordinator.goToFindPassword()
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
    
    public func processLogin() {
        if let password = passwordValue.value {
            let loginRequest = LoginRequest(email: emailValue, password: password, socialType: socialType.value)
            AuthAPIRequest.login(request: loginRequest, completion: { result in
                switch result {
                case .success(let response):
                    let epochTime = TimeInterval(response.data.expiresIn) / 1000
                    DebugLog("Login AccessToken : \(response.data.accessToken), EpochTime: \(epochTime)")
                    
                    let setAccessTokenResult = TokenManager.shared.setAccessToken(token: response.data.accessToken)
                    let setRefreshTokenResult = TokenManager.shared.setRefreshToken(token: response.data.refreshToken)
                    let setExpiredInResult = TokenManager.shared.setAccessTokenExpiredDate(expiredAt: Date(timeIntervalSince1970: epochTime))
                    
                    if setAccessTokenResult && setRefreshTokenResult && setExpiredInResult {
                        DebugLog("Move To Main")
                        self.goToMain()
                    }
                case .failure(let error):
                    ErrorLog(error.localizedDescription)
                }
            })
        } else {
            ErrorLog("Password를 입력해주세요.")
        }
    }
}
