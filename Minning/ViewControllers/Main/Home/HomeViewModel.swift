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
    var retrospects: DataBinding<[RetrospectModel]> = DataBinding([])
    var checkTodaySaying: DataBinding<Bool> = DataBinding(false)
    var missions: DataBinding<[MissionModel]> = DataBinding([])
    
    private var selectedDay: Day {
        Day.allCases[selectedDate.value.get(.weekday) - 1]
    }
    
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
        let index = Calendar.current.component(.weekday, from: selectedDate.value)
        let startDay = Date(timeInterval: -(Double(86400 * ((index + 5) % 7))), since: selectedDate.value)
        
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
        RoutineAPIRequest.routineListByDay(date: selectedDate.value.convertToSmallString()) { result in
            switch result {
            case .success(let response):
                self.routines.accept(response.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func getAllRetrospectByDay() {
        RetrospectAPIRequest.retrospectListByDate(date: selectedDate.value.convertToSmallString()) { result in
            switch result {
            case .success(let response):
                self.retrospects.accept(response.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func getSayingCheck() {
        SayingAPIRequest.checkTodaySaying { result in
            switch result {
            case .success(let data):
                self.checkTodaySaying.accept(data.data.result)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func postRoutineResult(routineId: Int64, result: RoutineResult) {
        RetrospectAPIRequest.setRetrospectResult(request: .init(date: selectedDate.value.convertToSmallString(), result: result.rawValue, routineId: routineId)) { result in
            switch result {
            case .success(_):
                self.getWeeklyRate()
                self.getAllRoutinesByDay()
                self.getAllRetrospectByDay()
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func getMissionInfo() {
        MissionAPIRequest.getMissionList { result in
            switch result {
            case .success(let response):
                self.missions.accept(response.data)
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
    
    public func goToModifyRoutine(with index: Int) {
        let routine = routines.value[index]
        coordinator.goToModifyRoutine(id: routine.id, title: routine.title, goal: routine.goal, category: routine.category, days: routine.days)
    }
    
    public func goToNotification() {
        coordinator.goToNotification()
    }
    
    public func showPhraseModally() {
        coordinator.goToPhrase()
    }
    
    public func showReviewFullModally(retrospect: RetrospectModel) {
        coordinator.goToReview(retrospect: retrospect)
    }
    
    public func goToEditOrder() {
        coordinator.goToEditOrder(day: selectedDay, routineList: routines.value)
    }
    
    public func goToMyGroup() {
        coordinator.goToMyGroup()
    }
    
    public func updateSelectedWeek(isForward: Bool) {
        let value = selectedDate.value
        let updateValue = Date(timeInterval: isForward ? 86400 * 7 : 86400 * -7, since: value)
        selectedDate.accept(updateValue)
        getWeeklyRate()
        getAllRoutinesByDay()
        getAllRetrospectByDay()
    }
}
