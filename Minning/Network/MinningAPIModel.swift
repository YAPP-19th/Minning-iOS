//
//  MinningAPIModel.swift
//  Minning
//
//  Created by denny on 2021/11/22.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

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
    public let profileUrl: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decode(String.self, forKey: .email)
        nickname = try values.decode(String.self, forKey: .nickname)
        profileUrl = try values.decode(String.self, forKey: .profile)
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
    public let content: String
    public let date: String
    public let id: Int64
    public let imageUrl: String
    public let result: String
    public let routine: RoutineModel
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
        case startTime
        case title
    }
    
    public let category: RoutineCategory
    public let days: [Day]
    public let goal: String
    public let id: Int64
    public let startTime: String
    public let title: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
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
        
        let daysValue = try values.decode([String].self, forKey: .days)
        var dayList: [Day] = []
        
        daysValue.forEach { dayString in
            dayList.append(Day(rawValue: dayString)!)
        }
        
        days = dayList
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
    public let rate: String
    
}

public struct ReportResponseModel: Codable {
    public let monthRoutineReportList: [ReportModel]
    public let weakRateList: [String]
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
    public let fullyDoneRate: String
    public let notDoneRate: String
    public let partiallyDoneRate: String
    public let title: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
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
        
        fullyDoneRate = try values.decode(String.self, forKey: .fullyDoneRate)
        notDoneRate = try values.decode(String.self, forKey: .notDoneRate)
        partiallyDoneRate = try values.decode(String.self, forKey: .partiallyDoneRate)
        title = try values.decode(String.self, forKey: .title)
    }
    
    public func encode(to encoder: Encoder) throws { }
}
