//
//  MinningAPIModel.swift
//  Minning
//
//  Created by denny on 2021/11/22.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import UIKit

public enum SocialProcess: String, Codable {
    case signUp = "SIGNUP"
    case login = "LOGIN"
}

public struct CommonAPIResponse: Codable {
    public let msg: String
    public let status: String
}

public struct MyInfoModel: Codable {
    enum CodingKeys: String, CodingKey {
        case email
        case nickname
        case profile
    }
    
    public let email: String
    public let nickname: String
    public var profileUrl: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decode(String.self, forKey: .email)
        nickname = try values.decode(String.self, forKey: .nickname)
        profileUrl = try values.decode(String?.self, forKey: .profile)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct UserResponseModel: Codable {
    public let data: MyInfoModel
    public let message: CommonAPIResponse
}

public struct EmailExistResponseModel: Codable {
    public let data: EmailExistModel
    public let message: CommonAPIResponse
}

public struct EmailExistModel: Codable {
    public let exist: Bool
}

public struct SocialCheckResponseModel: Codable {
    public let data: SocialDataResponseModel
    public let message: CommonAPIResponse
}

public struct SocialDataResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case data
        case processes
    }
    
    public var tokenData: AccessTokenModel?
    public var userData: SocialDataUserModel?
    public let processes: SocialProcess
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let processValue = try values.decode(String.self, forKey: .processes)
        processes = (processValue == "SIGNUP") ? .signUp : .login
        
        if processes == .login {
            tokenData = try values.decode(AccessTokenModel.self, forKey: .data)
        } else {
            userData = try values.decode(SocialDataUserModel.self, forKey: .data)
        }
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct SocialDataUserModel: Codable {
    enum CodingKeys: String, CodingKey {
        case email
        case socialType
    }
    
    public let email: String
    public let socialType: SocialType
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decode(String.self, forKey: .email)
        
        let socialTypeValue = try values.decode(String.self, forKey: .socialType)
        socialType = SocialType(rawValue: socialTypeValue) ?? .kakao
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct LoginResponseModel: Codable {
    public let data: AccessTokenModel
    public let message: CommonAPIResponse
}

public struct SignUpResponseModel: Codable {
    public let data: AccessTokenModel
    public let message: CommonAPIResponse
}

public struct RefreshTokenResponseModel: Codable {
    public let data: AccessTokenModel
    public let message: CommonAPIResponse
}

public struct AccessTokenModel: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case expiresIn = "accessTokenExpiresIn"
        case grantType
    }
    
    public let accessToken: String
    public let refreshToken: String
    public let expiresIn: Int64
    public let grantType: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        refreshToken = try values.decode(String.self, forKey: .refreshToken)
        expiresIn = try values.decode(Int64.self, forKey: .expiresIn)
        grantType = try values.decode(String.self, forKey: .grantType)
    }
}

public struct RetrospectListResponseModel: Codable {
    public let data: [RetrospectModel]
    public let message: CommonAPIResponse
}

public struct RetrospectResponseModel: Codable {
    public let data: RetrospectModel
    public let message: CommonAPIResponse
}

public struct RetrospectModel: Codable {
    enum CodingKeys: String, CodingKey {
        case image
        case content
        case date
        case id
        case result
        case routine
    }
    
    public let content: String?
    public let date: String
    public let id: Int64
    public let imageUrl: String?
    public let result: String
    public let routine: RoutineModel
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decode(String?.self, forKey: .image)
        content = try values.decode(String?.self, forKey: .content)
        id = try values.decode(Int64.self, forKey: .id)
        result = try values.decode(String.self, forKey: .result)
        routine = try values.decode(RoutineModel.self, forKey: .routine)
        date = try values.decode(String.self, forKey: .date)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct RoutineResponseModel: Codable {
    public let data: RoutineModel
    public let message: CommonAPIResponse
}

public struct RoutineListResponseModel: Codable {
    public let data: [RoutineModel]
    public let message: CommonAPIResponse
}

public struct RoutineModel: Codable {
    enum CodingKeys: String, CodingKey {
        case category
        case days
        case goal
        case id
        case result
        case startTime
        case title
    }
    
    public let category: RoutineCategory
    public let days: [Day]
    public let goal: String
    public let id: Int64
    public let result: RoutineResult
    public let startTime: String
    public let title: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let categoryValue = try values.decode(Int.self, forKey: .category)
        
        category = RoutineCategory(rawValue: categoryValue) ?? .other

        let daysValue = try values.decode([String].self, forKey: .days)
        var dayList: [Day] = []
        
        daysValue.forEach { dayString in
            dayList.append(Day(rawValue: dayString)!)
        }
        
        days = dayList
        
        let resultValue = try values.decode(String.self, forKey: .result)
        result = RoutineResult(rawValue: resultValue) ?? .failure
        
        goal = try values.decode(String.self, forKey: .goal)
        id = try values.decode(Int64.self, forKey: .id)
        startTime = try values.decode(String.self, forKey: .startTime)
        title = try values.decode(String.self, forKey: .title)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct RoutinePercentResponseModel: Codable {
    public let data: [RoutinePercentModel]
    public let message: CommonAPIResponse
}

public struct RoutinePercentModel: Codable {
    public let date: String
    public let fullyDone: Int
    public let partiallyDone: Int
    public let totalDone: Int
    public let rate: Int
    
}

public struct ReportMonthModel: Codable {
    public let resultByCategory: [ReportMonthDataModel]
    public let weekRateList: [Int]
}

public struct ReportMonthDataModel: Codable {
    public let rate: Int
    public let routineReportList: [ReportModel]
}

public struct ReportMonthResponseModel: Codable {
    public let data: ReportMonthModel
    public let message: CommonAPIResponse
}

public struct ReportWeekResponseModel: Codable {
    public let data: ReportWeekModel
    public let message: CommonAPIResponse
}

public struct ReportWeekModel: Codable {
    public let fullyDoneCount: Int
    public let lastDate: String
    public let notDoneCount: Int
    public let partiallyDoneCount: Int
    public let rate: String
    public let responseWeekRoutine: [ReportWeekRoutineModel]
}

public struct ReportWeekRoutineModel: Codable {
    public let retrospectDayList: [ReportRetrospectModel]
    public let title: String
}

public struct ReportRetrospectModel: Codable {
    enum CodingKeys: String, CodingKey {
        case day
        case result
    }
    
    public let day: Day
    public let result: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dayValue = try values.decode(String.self, forKey: .day)
        day = Day(rawValue: dayValue)!
        result = try values.decode(String.self, forKey: .result)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct ReportModel: Codable {
    enum CodingKeys: String, CodingKey {
        case category
        case fullyDoneRate
        case notDoneRate
        case partiallyDoneRate
        case title
    }
    
    public let category: RoutineCategory
    public let fullyDoneRate: Int
    public let notDoneRate: Int
    public let partiallyDoneRate: Int
    public let title: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let categoryValue = try values.decode(Int.self, forKey: .category)
        DebugLog("1")
        
        switch categoryValue {
        case 0:
            category = .miracle
        case 1:
            category = .selfDev
        case 2:
            category = .health
        case 3:
            category = .life
        case 4:
            category = .other
        default:
            category = .other
        }
        
        fullyDoneRate = try values.decode(Int.self, forKey: .fullyDoneRate)
        DebugLog("2")
        notDoneRate = try values.decode(Int.self, forKey: .notDoneRate)
        DebugLog("3")
        partiallyDoneRate = try values.decode(Int.self, forKey: .partiallyDoneRate)
        DebugLog("4")
        title = try values.decode(String.self, forKey: .title)
        DebugLog("5")
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct SayingCompareResponseModel: Codable {
    public let data: SayingCompareModel
    public let message: CommonAPIResponse
}

public struct SayingCompareModel: Codable {
    public let id: Int64
    public let result: Bool
}

public struct TodaySayingCheckResponseModel: Codable {
    public let data: BoolModel
    public let message: CommonAPIResponse
}

public struct BoolModel: Codable {
    public let result: Bool
}

public struct SayingResponseModel: Codable {
    public let data: SayingModel
    public let message: CommonAPIResponse
}

public struct SayingModel: Codable {
    public let author: String
    public let content: String
    public let id: Int64
}

public struct GroupResponseModel: Codable {
    public let data: [GroupModel]
    public let message: CommonAPIResponse
}

public struct GroupModel: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case participant
        case rate
        case title
    }
    
    public let id: Int64
    public let imageUrl: String
    public let participant: Int
    public let rate: Int
    public let title: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        imageUrl = try values.decode(String.self, forKey: .image)
        title = try values.decode(String.self, forKey: .title)
        participant = try values.decode(Int.self, forKey: .participant)
        rate = try values.decode(Int.self, forKey: .rate)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct GroupDetailResponseModel: Codable {
    public let data: GroupDetailModel
    public let message: CommonAPIResponse
}

public struct GroupDetailModel: Codable {
    enum CodingKeys: String, CodingKey {
        case beginTime
        case endTime
        case category
        case description
        case recommend
        case id
        case participant
        case rate
        case shoot
        case title
    }
    
    public let beginTime: String
    public let endTime: String
    public let category: RoutineCategory
    public let description: String
    public let recommend: String
    public let id: Int64
    public var participant: Int?
    public var rate: Int?
    public let shoot: String
    public let title: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let categoryValue = try values.decode(Int.self, forKey: .category)
        category = RoutineCategory(rawValue: categoryValue) ?? .other
        title = try values.decode(String.self, forKey: .title)
        shoot = try values.decode(String.self, forKey: .shoot)
        beginTime = try values.decode(String.self, forKey: .beginTime)
        endTime = try values.decode(String.self, forKey: .endTime)
        description = try values.decode(String.self, forKey: .description)
        recommend = try values.decode(String.self, forKey: .recommend)
        id = try values.decode(Int64.self, forKey: .id)
        participant = try values.decode(Int?.self, forKey: .participant)
        rate = try values.decode(Int?.self, forKey: .rate)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct TimeModel: Codable {
    public let hour: Int
    public let minute: Int
    public let nano: Int
    public let second: Int
}

public struct DoTodayMissionResponseModel: Codable {
    public let data: BoolModel
    public let message: CommonAPIResponse
}

public struct DeleteCaptureResponseModel: Codable {
    public let data: BoolModel
    public let message: CommonAPIResponse
}

public struct CaptureListResponseModel: Codable {
    public let data: CaptureListModel
    public let message: CommonAPIResponse
}

public struct CaptureListModel: Codable {
    public let captures: [CaptureModel]
}

public struct CaptureModel: Codable {
    enum CodingKeys: String, CodingKey {
        case captureId
        case images
    }
    
    public let captureId: Int64
    public let imageUrl: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        imageUrl = try values.decode(String.self, forKey: .images)
        captureId = try values.decode(Int64.self, forKey: .captureId)
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct MissionListResponseModel: Codable {
    public let data: [MissionModel]
    public let message: CommonAPIResponse
}

public struct MissionModel: Codable {
    enum CodingKeys: String, CodingKey {
        case achievementRate
        case category
        case image
        case period
        case title
        case todayCertificate
        case weeks
    }
    
    public let achievementRate: Int32?
    public let category: Int32
    public let imageUrl: String?
    public let period: Int32
    public let title: String
    public let todayCertificate: Bool
    public let weeks: [Day]
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        achievementRate = try values.decode(Int32?.self, forKey: .achievementRate)
        category = try values.decode(Int32.self, forKey: .category)
        imageUrl = try values.decode(String?.self, forKey: .image)
        period = try values.decode(Int32.self, forKey: .period)
        title = try values.decode(String.self, forKey: .title)
        todayCertificate = try values.decode(Bool.self, forKey: .todayCertificate)
        
        let weeksValue = try values.decode([String].self, forKey: .weeks)
        weeks = weeksValue.map { Day(rawValue: $0)! }
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct MissionDetailResponseModel: Codable {
    public let data: MissionDetailModel
    public let message: CommonAPIResponse
}

public struct MissionDetailModel: Codable {
    enum CodingKeys: String, CodingKey {
        case beginTime
        case endTime
        case category
        case endDate
        case groupAchievementRate
        case myAchievementRate
        case nowPeople
        case participant
        case period
        case shoot
        case title
        case weeks
    }
    
    public let beginTime: TimeModel
    public let endTime: TimeModel
    public let category: RoutineCategory
    public let endDate: String
    public let groupAchievementRate: Int
    public let myAchievementRate: Int
    public let nowPeople: Int
    public let participant: Int
    public let period: Int
    public let shoot: String
    public let title: String
    public let weeks: [Day]
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        beginTime = try values.decode(TimeModel.self, forKey: .beginTime)
        endTime = try values.decode(TimeModel.self, forKey: .endTime)
        endDate = try values.decode(String.self, forKey: .endDate)
        groupAchievementRate = try values.decode(Int.self, forKey: .groupAchievementRate)
        myAchievementRate = try values.decode(Int.self, forKey: .myAchievementRate)
        period = try values.decode(Int.self, forKey: .period)
        participant = try values.decode(Int.self, forKey: .participant)
        nowPeople = try values.decode(Int.self, forKey: .nowPeople)
        title = try values.decode(String.self, forKey: .title)
        shoot = try values.decode(String.self, forKey: .shoot)
        
        let categoryValue = try values.decode(String.self, forKey: .category)
        
        switch categoryValue {
        case "건강":
            category = .health
        case "생활":
            category = .life
        case "자기개발":
            category = .selfDev
        case "미라클모닝":
            category = .miracle
        case "기타":
            category = .other
        default:
            category = .other
        }
        
        let weeksValue = try values.decode([String].self, forKey: .weeks)
        weeks = weeksValue.map { Day(rawValue: $0)! }
    }
    
    public func encode(to encoder: Encoder) throws { }
}

public struct NoticeResponseModel: Codable {
    public let data: [NoticeModel]
    public let message: CommonAPIResponse
}

public struct NoticeDetailResponseModel: Codable {
    public let data: NoticeModel
    public let message: CommonAPIResponse
}

public struct NoticeModel: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case createdAt
        case title
    }
    
    public let id: Int
    public let title: String
    public let createdAt: String
    public let content: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        content = try values.decode(String.self, forKey: .content)
    }
    
    public func encode(to encoder: Encoder) throws { }
}
