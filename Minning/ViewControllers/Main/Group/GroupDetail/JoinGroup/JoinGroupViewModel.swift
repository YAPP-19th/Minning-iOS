//
//  JoinGroupViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class JoinGroupViewModel {
    let periodSymbols = ["1주", "2주", "1달", "2달", "4달"]
    let daySymbols = ["월", "화", "수", "목", "금", "토", "일"]
    let notiSymbols = ["오전 5시", "오전 6시", "오전 7시"]
    
    var selectedPeriod: DataBinding<Int?> = DataBinding(nil)
    var selectedDay: DataBinding<Int?> = DataBinding(nil)
    var selectedNoti: DataBinding<Int?> = DataBinding(nil)
    
    private let coordinator: GroupCoordinator
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
}
