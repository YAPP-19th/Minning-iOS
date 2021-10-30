//
//  PhotoGridViewModel.swift
//  Minning
//
//  Created by 고세림 on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

final class PhotoGridViewModel {
    private let coordinator: GroupCoordinator
    
    var selectedItemCount: Int = 0
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
}
