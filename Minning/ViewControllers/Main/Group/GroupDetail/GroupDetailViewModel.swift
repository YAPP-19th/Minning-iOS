//
//  GroupDetailViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class GroupDetailViewModel {
    var groupItem: DataBinding<Group?> = DataBinding(nil)
    private let coordinator: GroupCoordinator
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
    
    func showJoinGroup(completion: ((Bool) -> Void)?) {
        coordinator.showJoinGroup(completion: completion)
    }
    
    func dismissVC() {
        coordinator.dismissVC()
    }
}
