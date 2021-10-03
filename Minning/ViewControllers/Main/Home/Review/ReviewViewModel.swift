//
//  ReviewViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class ReviewViewModel {
    var routimeItem: DataBinding<Routine?> = DataBinding(nil)
    var feedbackContent: DataBinding<String> = DataBinding("")
    
    let feedbackPlaceholder: String = "피드백을 적어주세요!"
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        
        // SAMPLE
        routimeItem.accept(Routine(title: "아침에 신문읽기", category: .life, result: .tried))
    }
}
