//
//  HomeDIContainer.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

final class HomeDIContainer {
    func createPhrase(_ coordinator: HomeCoordinator) -> PhraseViewController {
        let viewModel = PhraseViewModel(coordinator: coordinator)
        let phraseVC = PhraseViewController(viewModel: viewModel)
        return phraseVC
    }
    
    func createAdd(_ coordinator: HomeCoordinator) -> AddViewController {
        let viewModel = AddViewModel(coordinator: coordinator)
        let addVC = AddViewController(viewModel: viewModel)
        return addVC
    }
    
    func createReview(_ coordinator: HomeCoordinator) -> ReviewViewController {
        let viewModel = ReviewViewModel(coordinator: coordinator)
        let addVC = ReviewViewController(viewModel: viewModel)
        return addVC
    }
    
    func createEditOrder(_ coordinator: HomeCoordinator) -> EditOrderViewController {
        let viewModel = EditOrderViewModel(coordinator: coordinator)
        let editOrderVC = EditOrderViewController(viewModel: viewModel)
        return editOrderVC
    }
    
    func createRecommend(_ coordinator: HomeCoordinator) -> RecommendViewController {
        let viewModel = RecommendViewModel(coordinator: coordinator)
        let recommendVC = RecommendViewController(viewModel: viewModel)
        return recommendVC
    }
    
    func createNotification(_ coordinator: HomeCoordinator) -> NotificationViewController {
        let viewModel = NotificationViewModel(coordinator: coordinator)
        let notificationVC = NotificationViewController(viewModel: viewModel)
        return notificationVC
    }
    
    func createMyPage(_ coordinator: HomeCoordinator) -> MyPageViewController {
        let viewModel = MyPageViewModel(coordinator: coordinator)
        let myPageVC = MyPageViewController(viewModel: viewModel)
        return myPageVC
    }
    
    func createResetPassword(_ coordinator: HomeCoordinator) -> ResetPasswordViewController {
        let viewModel = ResetPasswordViewModel(coordinator: coordinator)
        let resetPasswordVC = ResetPasswordViewController(viewModel: viewModel)
        return resetPasswordVC
    }
    
    func createNotice(_ coordinator: HomeCoordinator) -> NoticeViewController {
        let viewModel = NoticeViewModel(coordinator: coordinator)
        let noticeVC = NoticeViewController(viewModel: viewModel)
        return noticeVC
    }
    
    func createLargeContents(_ coordinator: HomeCoordinator, contentType: MyPageSettingRowItem.RowType) -> LargeContentsViewController {
        let viewModel = LargeContentsViewModel(coordinator: coordinator, contentType: contentType)
        let largeContentsVC = LargeContentsViewController(viewModel: viewModel)
        return largeContentsVC
    }
    
    func createInquire(_ coordinator: HomeCoordinator) -> InquireViewController {
        let viewModel = InquireViewModel(coordinator: coordinator)
        let inquireVC = InquireViewController(viewModel: viewModel)
        return inquireVC
    }
    
    func createVersion(_ coordinator: HomeCoordinator) -> VersionViewController {
        let viewModel = VersionViewModel(coordinator: coordinator)
        let versionVC = VersionViewController(viewModel: viewModel)
        return versionVC
    }
}
