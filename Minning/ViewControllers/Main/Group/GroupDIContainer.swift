//
//  GroupDIContainer.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

final class GroupDIContainer {
    func createDetail(_ coordinator: GroupCoordinator) -> GroupDetailViewController {
        let viewModel = GroupDetailViewModel(coordinator: coordinator)
        let detailVC = GroupDetailViewController(viewModel: viewModel)
        return detailVC
    }
    
    func createJoinGroup(_ coordinator: GroupCoordinator) -> JoinGroupViewController {
        let viewModel = JoinGroupViewModel(coordinator: coordinator)
        let joinGroupVC = JoinGroupViewController(viewModel: viewModel)
        return joinGroupVC
    }
}
