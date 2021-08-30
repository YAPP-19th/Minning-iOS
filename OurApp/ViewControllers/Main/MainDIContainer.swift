//
//  MainDIContainer.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation
import UIKit

final class MainDIContainer {
    func createSample(_ coordinator: MainCoordinator) -> SampleViewController {
        let viewModel = SampleViewModel(coordinator: coordinator)
        let vc = SampleViewController(viewModel: viewModel)
        return vc
    }
}
