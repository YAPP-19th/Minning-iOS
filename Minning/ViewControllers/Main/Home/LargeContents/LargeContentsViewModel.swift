//
//  LargeContentsViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/31.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class LargeContentsViewModel {
    var contentType: DataBinding<MyPageSettingRowItem.RowType> = DataBinding(.agreement)
    private let coordinator: HomeCoordinator
    
    public init(coordinator: HomeCoordinator, contentType: MyPageSettingRowItem.RowType) {
        self.coordinator = coordinator
        self.contentType.accept(contentType)
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
