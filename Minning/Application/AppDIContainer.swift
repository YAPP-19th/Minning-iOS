//
//  AppDIContainer.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

final class AppDIContainer {
    let appConfiguration = AppConfiguration()
    
    func createSplash(coordinator: AppCoordinator) -> SplashViewController {
        let viewModel = SplashViewModel(coordinator: coordinator)
        let vc = SplashViewController(viewModel: viewModel)
        return vc
    }
}
