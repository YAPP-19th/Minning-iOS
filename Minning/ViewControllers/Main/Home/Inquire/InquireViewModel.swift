//
//  InquireViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/31.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class InquireViewModel {
    private let coordinator: HomeCoordinator
    
    public init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
