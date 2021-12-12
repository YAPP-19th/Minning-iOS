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
    var weeklyRoutineRate: DataBinding<[RoutinePercentModel]> = DataBinding([])
    var selectedDate: DataBinding<Date> = DataBinding(Date())
    var tabType: DataBinding<RoutineTabType> = DataBinding(.routine)
    var routines: DataBinding<[RoutineModel]> = DataBinding([])
    
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
    
    public func getWeeklyRate() {
        let index = Calendar.current.component(.weekday, from: Date())
        let startDay = Date(timeIntervalSinceNow: -(Double(86400 * ((index + 5) % 7))))
        
        RoutineAPIRequest.getRoutinePercentPerWeek(date: startDay.convertToSmallString()) { result in
            switch result {
            case .success(let response):
                self.weeklyRoutineRate.accept(response.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func getAllRoutinesByDay() {
        let index = selectedDate.value.get(.weekday)
        RoutineAPIRequest.routineListByDay(day: Day.allCases[index]) { result in
            switch result {
            case .success(let response):
                self.routines.accept(response.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
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
