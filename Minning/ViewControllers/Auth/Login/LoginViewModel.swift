//
//  LoginViewModel.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
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
    
    public func processSocialCheck(socialType: SocialType, token: String) {
        let socialRequest = SocialRequest(socialType: socialType, token: token)
        DebugLog("Social Check API Start")
        AuthAPIRequest.socialCheck(request: socialRequest, completion: { result in
            switch result {
            case .success(let response):
                // 회원인 경우
                DebugLog("SocialCheck AccessToken : \(response.data.accessToken)")
                
            case .failure(let error):
                // 회원이 아닌 경우
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
                    DebugLog("nickname: \(kakaoUser.kakaoAccount?.profile?.nickname ?? "nil")")
                    DebugLog("userId: \(String(describing: kakaoUser.id))")
                    DebugLog("Email: \(kakaoUser.kakaoAccount?.email ?? "nil")")
                    self.processSocialCheck(socialType: .kakao, token: token)
                }
            }
        })
    }
}
