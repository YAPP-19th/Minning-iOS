//
//  SettingModel.swift
//  Minning
//
//  Created by denny on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public struct MyPageSettingRowItem: Equatable {
    public enum RowType: Equatable {
        case rePassword
        case push
        case notice
        case inquire
        case agreement
        case personalInfo
        case version
        case logout
        case deleteAccount
        
        var displayText: String {
            switch self {
            case .rePassword:
                return "비밀번호 재설정"
            case .push:
                return "미닝 푸쉬 알림 받기"
            case .notice:
                return "미닝 공지사항"
            case .inquire:
                return "문의하기"
            case .agreement:
                return "이용약관"
            case .personalInfo:
                return "개인정보 처리방침"
            case .version:
                return "버전 정보"
            case .logout:
                return "로그아웃"
            case .deleteAccount:
                return "계정 삭제"
            }
        }
    }
    
    public let type: RowType
    public var title: String {
        type.displayText
    }
    
    public var cellIdentifier: String {
        switch type {
        case .push:
            return SwitchSettingCell.identifier
        default:
            return NormalSettingCell.identifier
        }
    }
}
