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
    enum SectionType: Int {
        case first = 1
        case second
        case third
    }
    
    var firstSectionRowItems: [MyPageSettingRowItem] = []
    var secondSectionRowItems: [MyPageSettingRowItem] = []
    var thirdSectionRowItems: [MyPageSettingRowItem] = []
    
    var sectionCount: Int {
        firstSectionRowItems.count + secondSectionRowItems.count + thirdSectionRowItems.count + 1
    }
    
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
    
    func getRowCount(section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            switch SectionType(rawValue: section) {
            case .first:
                return firstSectionRowItems.count
            case .second:
                return secondSectionRowItems.count
            case .third:
                return thirdSectionRowItems.count
            default:
                return 0
            }
        }
    }
    
    func getSectionRowItems(section: Int) -> [MyPageSettingRowItem] {
        switch SectionType(rawValue: section) {
        case .first:
            return firstSectionRowItems
        case .second:
            return secondSectionRowItems
        case .third:
            return thirdSectionRowItems
        default:
            return []
        }
    }
    
    public func goToBack() {
        coordinator.goToBack()
    }
    
    public func goToSettingContent(type: MyPageSettingRowItem.RowType) {
        switch type {
        case .rePassword:
            coordinator.goToResetPassword()
        case .notice:
            coordinator.goToNotice()
        case .inquire:
            coordinator.goToInquire()
        case .agreement:
            coordinator.goToLargeContents(contentType: .agreement)
        case .personalInfo:
            coordinator.goToLargeContents(contentType: .personalInfo)
        case .version:
            coordinator.goToVersion()
        default:
            break
        }
    }
}
