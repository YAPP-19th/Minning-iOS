//
//  StartDIContainer.swift
//  Minning
//
//  Created by denny on 2021/12/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

final class StartDIContainer {
    func createOnboarding(coordinator: StartCoordinator) -> OnBoardingViewController {
        let viewModel = OnBoardingViewModel(coordinator: coordinator)
        let vc = OnBoardingViewController(viewModel: viewModel)
        return vc
    }
}
