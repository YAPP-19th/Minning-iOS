//
//  MainCoordinator.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class MainCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SampleViewModel(coordinator: self)
        let vc = SampleViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
}
