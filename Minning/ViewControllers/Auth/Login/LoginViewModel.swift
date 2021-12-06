//
//  LoginViewModel.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

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
    
    public func requestKakaoTalkLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    ErrorLog(error.localizedDescription)
                } else {
                    // Kakao Login Success
                    if let accessToken = oauthToken?.accessToken {
                        self.getKakaoUserInfo(token: accessToken)
                    }
                }
            }
        } else {
            requestKakaoAccountLogin()
        }
    }
    
    private func requestKakaoAccountLogin() {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            if let error = error {
                ErrorLog(error.localizedDescription)
            } else {
                DebugLog("loginWithKakaoAccount() success ===> \(String(describing: oauthToken))")
                if let accessToken = oauthToken?.accessToken {
                    self.getKakaoUserInfo(token: accessToken)
                }
            }
        }
    }
    
    private func getKakaoUserInfo(token: String) {
        UserApi.shared.me(completion: { user, error in
            if let error = error {
                ErrorLog(error.localizedDescription)
            } else {
                DebugLog("me() success.")
                
                if let kakaoUser = user {
                    DebugLog("[로그인된 사용자 정보]\nnickname: \(kakaoUser.kakaoAccount?.profile?.nickname ?? "nil")\nuserId: \(String(describing: kakaoUser.id))")
                    if let kakaoUserId = kakaoUser.id,
                        let email = kakaoUser.kakaoAccount?.email {
                        self.processSocialCheck(email: email, id: kakaoUserId, socialType: .kakao, token: token)
                    }
                }
            }
        })
    }
}
