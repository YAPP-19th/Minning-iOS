//
//  NotificationViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class NotificationViewModel {
    // SAMPLE
    var sampleNotiList: DataBinding<[NotificationModel]> = DataBinding([])
    
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func createSampleDate() {
        for _ in 0..<5 {
            var list = sampleNotiList.value
            let notification = NotificationModel(title: "새로운 리포트가 도착했어요",
                                                 description: "2021년 10월 3일 부터 7일까지의 리포트가 도착했습니다.",
                                                 date: Date())
            list.append(notification)
            sampleNotiList.accept(list)
        }
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
