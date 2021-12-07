//
//  NicknameViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

final class NicknameViewModel {
    private let coordinator: AuthCoordinator
    
    private let email: String?
    private let password: String?
    
    private let isSocial: Bool
    private let socialType: SocialType?
    private let token: String?
    
    public var nickname: DataBinding<String> = DataBinding("")
    
    public init(coordinator: AuthCoordinator,
                email: String?, password: String?,
                isSocial: Bool, socialType: SocialType? = nil, token: String? = nil) {
        self.coordinator = coordinator
        self.email = email
        self.password = password
        self.isSocial = isSocial
        self.socialType = socialType
        self.token = token
    }
    
    public func goToMain() {
        coordinator.goToMain(asRoot: true)
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
    
    public func processSignUp() {
        if isSocial {
            processSocialSignUp()
        } else {
            DebugLog("Normal Sign Up")
        }
    }
    
    private func processSocialSignUp() {
        if let socialType = socialType, let socialToken = token {
            let socialSignUpRequest = SocialSignUpRequest(token: socialToken, nickname: nickname.value, socialType: socialType)
            AuthAPIRequest.socialSignUp(request: socialSignUpRequest, completion: { result in
                switch result {
                case .success(let response):
                    let epochTime = TimeInterval(response.data.expiresIn) / 1000
                    DebugLog("Social SignUp AccessToken : \(response.data.accessToken), EpochTime: \(epochTime)")
                    
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
        }
    }
}
