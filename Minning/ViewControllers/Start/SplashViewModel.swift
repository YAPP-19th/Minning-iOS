//
//  SplashViewModel.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class SplashViewModel {
    private let coordinator: AppCoordinator
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    public func checkSplashState() {
        goToMain()
//        if AppConfiguration.shared.isFirstLaunch {
//            AppConfiguration.shared.isFirstLaunch = false
//            DebugLog("First Launch ==> OnBoarding")
//            goToOnboarding()
//        } else {
//            if !TokenManager.shared.checkAccessTokenExpired(), AppConfiguration.shared.isAutoLogin {
//                DebugLog("AccessToken Not Expired. Auto Login ==> Go to Main.")
//                goToMain()
//            }
//            let deleteResult = TokenManager.shared.deleteAllTokenData()
//            DebugLog("Go to Login ==> Token Delete Result: \(deleteResult)")
//            goToLogin()
//        }
    }
    
    private func goToMain() {
        coordinator.gotoMain()
    }
    
    private func goToLogin() {
        coordinator.gotoLogin(asRoot: true)
    }
    
    private func goToOnboarding() {
        coordinator.gotoOnBoarding()
    }
}
