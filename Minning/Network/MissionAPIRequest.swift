//
//  MissionAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem
import Pageboy

public struct MissionRequest {
    let finishDate: String
    let groupId: Int64
    let isAlarm: Bool
    let startDate: String
    let startTime: String
    let weeks: [String]
}

public struct MissionAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case missionList
        case createMission(request: MissionRequest)
        case missionDetail(missionId: Int64)
        case deleteMission(missionId: Int64)
        case endedMissionList
        
        var requestURL: URL {
            switch self {
            case .missionList:
                return MinningAPIConstant.missionURL
            case .createMission:
                return MinningAPIConstant.missionURL
            case let .missionDetail(missionId):
                return MinningAPIConstant.missionURL.appendingPathComponent("\(missionId)")
            case let .deleteMission(missionId):
                return MinningAPIConstant.missionURL.appendingPathComponent("\(missionId)")
            case .endedMissionList:
                return MinningAPIConstant.missionURL.appendingPathComponent("finish")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .missionList, .missionDetail, .endedMissionList:
                return .get
            case .createMission:
                return .post
            case .deleteMission:
                return .delete
            }
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .createMission(request):
                parameters["finishDate"] = request.finishDate
                parameters["id"] = request.groupId
                parameters["isAlarm"] = request.isAlarm
                parameters["startDate"] = request.startDate
                parameters["startTime"] = request.startTime
                parameters["weeks"] = request.weeks
                return parameters
            case .missionList, .missionDetail, .deleteMission, .endedMissionList:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            return .urlQuery
        }
    }
    
    public static func getMissionList(completion: @escaping (Result<MissionListResponseModel, Error>) -> Void) {
        perform(.missionList, completion: completion)
    }
    
    public static func createMission(request: MissionRequest, completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.createMission(request: request), completion: completion)
    }
    
    public static func getEndedMissionList(completion: @escaping (Result<MissionListResponseModel, Error>) -> Void) {
        perform(.endedMissionList, completion: completion)
    }
    
    public static func getMissionDetail(missionId: Int64, completion: @escaping (Result<MissionDetailResponseModel, Error>) -> Void) {
        perform(.missionDetail(missionId: missionId), completion: completion)
    }
    
    public static func deleteMission(missionId: Int64, completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.deleteMission(missionId: missionId), completion: completion)
    }
}
