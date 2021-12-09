//
//  HomeViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class HomeViewModel {
    enum RoutineTabType {
        case routine
        case review
    }
    
    private let coordinator: HomeCoordinator
    var myInfo: DataBinding<User?> = DataBinding(nil)
    var tabType: DataBinding<RoutineTabType> = DataBinding(.routine)
    
    public init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public func getUserData() {
        AccountAPIRequest.myInfo(completion: { result in
            switch result {
            case .success(let userModel):
                self.myInfo.accept(User(userModel: userModel.data))
            case .failure(let error):
                ErrorLog(error.defaultError.localizedDescription)
            }
        })
    }
    
    public func goToMyPage() {
        coordinator.goToMyPage()
    }
    
    public func goToAdd() {
        coordinator.goToAdd()
    }
    
    public func goToNotification() {
        coordinator.goToNotification()
    }
    
    public func showPhraseModally() {
        coordinator.goToPhrase()
    }
    
    public func showReviewFullModally() {
        coordinator.goToReview()
    }
    
    public func goToEditOrder() {
        coordinator.goToEditOrder()
    }
    
    public func goToReview() {
        coordinator.goToReview()
    }
    
    public func goToMyGroup() {
        coordinator.goToMyGroup()
    }
}
