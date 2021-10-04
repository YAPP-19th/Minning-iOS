//
//  GroupViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class GroupViewModel {
    enum GroupTabType {
        case myGroup
        case groupList
    }
    
    var tabType: DataBinding<GroupTabType> = DataBinding(.myGroup)
    private let coordinator: GroupCoordinator
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
    
    func showDetail() {
        coordinator.showDetail()
    }
    
    func goToNewGroup() {
        coordinator.goToNewGroup()
    }
}
