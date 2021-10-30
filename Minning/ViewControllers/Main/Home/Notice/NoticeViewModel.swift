//
//  NoticeViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class NoticeViewModel {
    // SAMPLE
    var sampleNotiList: DataBinding<[NotificationModel]> = DataBinding([])
    
    private let coordinator: HomeCoordinator
    
    public init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func createSampleDate() {
        for _ in 0..<5 {
            var list = sampleNotiList.value
            let notification = NotificationModel(title: "공지 제목입니다",
                                                 description: "공지 내용이 나오는 부분입니다",
                                                 date: Date())
            list.append(notification)
            sampleNotiList.accept(list)
        }
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
}
