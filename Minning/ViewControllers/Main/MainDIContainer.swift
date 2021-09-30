//
//  MainDIContainer.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import DesignSystem
import Foundation

final class MainDIContainer {
    func createMainTab(_ coordinator: MainCoordinator) -> MainTabBarViewController {
        let tabBarController = MainTabBarViewController(coordinator: coordinator)
        return tabBarController
    }
}
