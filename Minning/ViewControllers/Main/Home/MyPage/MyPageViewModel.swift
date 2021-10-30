//
//  MyPageViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class MyPageViewModel {
    private var firstSectionRowItems: [MyPageSettingRowItem] = []
    private var secondSectionRowItems: [MyPageSettingRowItem] = []
    private var thirdSectionRowItems: [MyPageSettingRowItem] = []
    
    private let coordinator: HomeCoordinator
    
    public init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        generateSettingItem()
    }
    
    private func generateSettingItem() {
        firstSectionRowItems.append(MyPageSettingRowItem(type: .rePassword))
        firstSectionRowItems.append(MyPageSettingRowItem(type: .push))
        secondSectionRowItems.append(MyPageSettingRowItem(type: .notice))
        secondSectionRowItems.append(MyPageSettingRowItem(type: .inquire))
        secondSectionRowItems.append(MyPageSettingRowItem(type: .agreement))
        secondSectionRowItems.append(MyPageSettingRowItem(type: .personalInfo))
        secondSectionRowItems.append(MyPageSettingRowItem(type: .version))
        thirdSectionRowItems.append(MyPageSettingRowItem(type: .logout))
        thirdSectionRowItems.append(MyPageSettingRowItem(type: .deleteAccount))
    }
}
