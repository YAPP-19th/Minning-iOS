//
//  GroupCellViewModel.swift
//  Minning
//
//  Created by 박지윤 on 2021/11/29.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupListCellViewModel {
//    let coordinator: GroupCoordinator
    
    var titles: [[String]] = [
        ["명상 그룹", "확언하기 그룹", "시각화 그룹", "감사 일기 쓰기 그룹", "다이어리 작성 그룹"],
        ["아침 4시 일어나기 그룹", "아침 5시 일어나기 그룹", "아침 6시 일어나기 그룹", "아침 7시 일어나기 그룹"],
        ["아침에 물 한잔 마시기 그룹", "침대 정리 그룹", "영양제 챙겨 먹기 그룹", "아침밥 챙겨 먹기 그룹", "환기하기 그룹", "방 정리하기 그룹", "모닝 커피 마시기 그룹", "샤워하기 그룹"],
        ["스트레칭 그룹", "요가 그룹", "산책하기 그룹", "러닝 그룹", "수면 일기 작성하기 그룹"],
        ["독서 그룹", "단어 외우기 그룹", "블로그 글 쓰기 그룹", "뉴스 읽기 그룹"]
    ]
    
    var cellColors: [UIColor] = [.cateRed100, .cateSky100, .cateGreen100, .catePurple100, .cateYellow100]
    
    var cellIcons: [String] = ["🌤", "🌤", "🏃🏻‍♀️", "👩‍💻", "🏡"]
    
    func cellCount() -> Int {
        var totalCount: Int = 0
        for title in titles {
            totalCount += title.count
        }
        return totalCount
    }
    
//    init(coordinator: GroupCoordinator) {
//        self.coordinator = coordinator
//    }
}
