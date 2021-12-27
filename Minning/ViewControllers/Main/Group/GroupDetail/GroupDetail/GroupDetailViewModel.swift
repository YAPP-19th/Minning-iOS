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
    var groupDetail: DataBinding<GroupDetailModel?> = DataBinding(nil)
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
    
    func goToPhotoGrid() {
        coordinator.goToPhotoGrid()
    }
    
    func getGroupDetail() {
        GroupAPIRequest.getGroupDetail(groupId: 1) { result in
            switch result {
            case .success(let data):
                self.groupDetail.accept(data.data)
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
    
//    func getMissionDetail() {
//        MissionAPIRequest.getMissionDetail(missionId: 1) { result in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                ErrorLog(error.localizedDescription)
//            }
//        }
//    }
}
