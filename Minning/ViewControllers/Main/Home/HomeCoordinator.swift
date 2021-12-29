//
//  HomeCoordinator.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

protocol HomeRoute {
    func goToPhrase()
    func goToRecommend()
    func goToAdd()
    func goToReview(retrospect: RetrospectModel)
    func goToEditOrder(day: Day, routineList: [RoutineModel])
    func goToNotification()
    func goToMyPage()
    func goToNotice()
    func goToResetPassword()
    func goToLargeContents(contentType: MyPageSettingRowItem.RowType)
    func goToInquire()
    func goToVersion()
    func goToBack()
    func goToLogin(asRoot: Bool)
}

class HomeCoordinator {
    let navigationController: UINavigationController
    
    private let dependencies: HomeDIContainer
    private let coordinator: MainCoordinator
    
    init(navigationController: UINavigationController,
         dependencies: HomeDIContainer,
         coordinator: MainCoordinator) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let homeVC = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeVC], animated: false)
    }
}

extension HomeCoordinator: HomeRoute {
    func goToPhrase() {
        let phraseVC = dependencies.createPhrase(self)
        navigationController.topViewController?.present(phraseVC, animated: true, completion: nil)
    }
    
    func goToRecommend() {
        let recommendVC = dependencies.createRecommend(self)
        navigationController.topViewController?.present(recommendVC, animated: true, completion: nil)
    }
    
    func goToAdd() {
        let addVC = dependencies.createAdd(self)
        navigationController.pushViewController(addVC, animated: true)
    }
    
    func goToReview(retrospect: RetrospectModel) {
        let reviewVC = dependencies.createReview(self, retrospect: retrospect)
        reviewVC.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.present(reviewVC, animated: true, completion: nil)
    }
    
    func goToEditOrder(day: Day, routineList: [RoutineModel]) {
        let editVC = dependencies.createEditOrder(self, day: day, routineList: routineList)
        navigationController.pushViewController(editVC, animated: true)
    }
    
    func goToNotification() {
        let notificationVC = dependencies.createNotification(self)
        notificationVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(notificationVC, animated: true)
    }
    
    func goToMyPage() {
        let myPageVC = dependencies.createMyPage(self)
        myPageVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(myPageVC, animated: true)
    }
    
    func goToNotice() {
        let noticeVC = dependencies.createNotice(self)
        noticeVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(noticeVC, animated: true)
    }
    
    func goToResetPassword() {
        let resetVC = dependencies.createResetPassword(self)
        resetVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(resetVC, animated: true)
    }
    
    func goToLargeContents(contentType: MyPageSettingRowItem.RowType) {
        let largeContentsVC = dependencies.createLargeContents(self, contentType: contentType)
        largeContentsVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(largeContentsVC, animated: true)
    }
    
    func goToInquire() {
        let inquireVC = dependencies.createInquire(self)
        inquireVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(inquireVC, animated: true)
    }
    
    func goToVersion() {
        let versionVC = dependencies.createVersion(self)
        versionVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(versionVC, animated: true)
    }
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToLogin(asRoot: Bool) {
        coordinator.goToLogin(asRoot: asRoot)
    }
    
    func goToMyGroup() {
        
    }
}
