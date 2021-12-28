//
//  GroupViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation

final class GroupViewModel {
    enum GroupTabType {
        case myGroup
        case groupList
    }
    
    enum MyGroupTabType {
        case now
        case done
    }
    
    private let coordinator: GroupCoordinator
    var tabType: DataBinding<GroupTabType> = DataBinding(.myGroup)
    var myGroupTabType: DataBinding<MyGroupTabType> = DataBinding(.now)
    var currentCategory: DataBinding<RoutineCategory?> = DataBinding(nil)
    var currentGroupCategory: DataBinding<GroupCategory?> = DataBinding(nil)
    var isCurrentCategoryAll: DataBinding<Bool> = DataBinding(true)
    var groups: DataBinding<[GroupModel]> = DataBinding([])
    var groupsByCategory: DataBinding<[GroupModel]> = DataBinding([])
    var ongoingGroupList: DataBinding<[MissionModel]> = DataBinding([])
    var endedGroupList: DataBinding<[MissionModel]> = DataBinding([])
    
    public var ongoingGroupsCount: Int = 0
    public var endedGroupsCount: Int = 0
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
    
    func showOpenedGroupDetail() {
        coordinator.showOpenedGroupDetail()
    }
    
    func showMygroup() {
        
    }
    
    func showOngoingGroup() {
        MissionAPIRequest.getMissionList { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                self.ongoingGroupList.accept(response.data)
                self.ongoingGroupsCount = response.data.count
                
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    func showEndedGroup() {
        MissionAPIRequest.getEndedMissionList { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                self.endedGroupList.accept(response.data)
                self.endedGroupsCount = response.data.count
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func getAllGroups() {
        GroupAPIRequest.getGroupList { result in
            switch result {
            case .success(let response):
                self.groups.accept(response.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    public func getGroupsFromCategory(category: Int32) {
        GroupAPIRequest.getGroupListByCategory(category: category) { result in
            switch result {
            case .success(let response):
                print(response.data)
                self.groupsByCategory.accept(response.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
    func goToNewGroup() {
        coordinator.goToNewGroup()
    }
}
