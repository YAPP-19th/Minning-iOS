//
//  GroupCoordinator.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol GroupRoute {
    func showDetail()
    func showJoinGroup(completion: (() -> Void)?)
    func showJoinGroup(completion: ((Bool) -> Void)?)
    func goToNewGroup()
    
    func goToBack()
    func dismissVC()
}

class GroupCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: GroupDIContainer
    private let coordinator: MainCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: GroupDIContainer,
         coordinator: MainCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start() {
        let viewModel = GroupViewModel(coordinator: self)
        let reportVC = GroupViewController(viewModel: viewModel)
        navigationController.setViewControllers([reportVC], animated: false)
    }
}

extension GroupCoordinator: GroupRoute {
    func showJoinGroup(completion: (() -> Void)?) {
        let joinGroupVC = dependencies.createJoinGroup(self)
        joinGroupVC.modalPresentationStyle = .overCurrentContext
    }
    
    func showJoinGroup(completion: ((Bool) -> Void)?) {
        let joinGroupVC = dependencies.createJoinGroup(self)
        joinGroupVC.modalPresentationStyle = .overCurrentContext
        joinGroupVC.completion = completion
        navigationController.topViewController?.presentedViewController?.present(joinGroupVC, animated: false, completion: nil)
    }
    
    func showDetail() {
        let detailVC = dependencies.createDetail(self)
        detailVC.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.present(detailVC, animated: true, completion: nil)
    }
    
    func goToPhotoGrid() {
        let photoGridVC = dependencies.createPhotoGrid(self)
        photoGridVC.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.presentedViewController?.present(photoGridVC, animated: true, completion: nil)
    }
    
    func goToNewGroup() {
        navigationController.topViewController?.presentedViewController
    }
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func dismissVC() {
        navigationController.topViewController?.dismiss(animated: true, completion: nil)
    }
}
