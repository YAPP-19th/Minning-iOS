//
//  CaptureAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public struct TodayMissionRequest {
    public let image: UIImage
    public let missionId: Int64
}

public struct CaptureAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case doTodayMission(request: TodayMissionRequest)
        case deleteMyImages(ids: [Int64])
        case getMyImages(missionId: Int64, page: Int32, recent: Int32, size: Int32)
        case getGroupImages(groupId: Int64, page: Int32, recent: Int32, size: Int32)
        
        var requestURL: URL {
            switch self {
            case .doTodayMission:
                return MinningAPIConstant.captureURL
            case .deleteMyImages:
                return MinningAPIConstant.captureURL
            case let .getMyImages(missionId, _, _, _):
                return MinningAPIConstant.captureURL.appendingPathComponent("mission").appendingPathComponent("\(missionId)")
            case let .getGroupImages(groupId, _, _, _):
                return MinningAPIConstant.captureURL.appendingPathComponent("org").appendingPathComponent("\(groupId)")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .doTodayMission:
                return .post
            case .deleteMyImages:
                return .delete
            case .getMyImages, .getGroupImages:
                return .get
            }
        }
        
        var image: UIImage? {
            switch self {
            case let .doTodayMission(request):
                return request.image
            default:
                return nil
            }
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .deleteMyImages(ids):
                parameters["captureIdLists"] = ids
                return parameters
            case let .getMyImages(_, page, recent, size):
                parameters["page"] = page
                parameters["recent"] = recent
                parameters["size"] = size
                return parameters
            case let .getGroupImages(_, page, recent, size):
                parameters["page"] = page
                parameters["recent"] = recent
                parameters["size"] = size
                return parameters
            case .doTodayMission:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .doTodayMission:
                return .multipartFormData
            case .deleteMyImages, .getMyImages, .getGroupImages:
                return .urlQuery
            }
        }
    }
    
    public static func doTodayMission(request: TodayMissionRequest,
                                      completion: @escaping (Result<DoTodayMissionResponseModel, Error>) -> Void) {
        performMultipart(.doTodayMission(request: request), completion: completion)
    }
    
    public static func deleteMyImages(ids: [Int64],
                                      completion: @escaping (Result<DeleteCaptureResponseModel, Error>) ->  Void) {
        perform(.deleteMyImages(ids: ids), completion: completion)
    }
    
    public static func getMyImages(missionId: Int64, page: Int32, recent: Int32, size: Int32,
                                   completion: @escaping (Result<CaptureListResponseModel, Error>) -> Void) {
        perform(.getMyImages(missionId: missionId, page: page, recent: recent, size: size), completion: completion)
    }
    
    public static func getGroupImages(groupId: Int64, page: Int32, recent: Int32, size: Int32,
                                   completion: @escaping (Result<CaptureListResponseModel, Error>) -> Void) {
        perform(.getGroupImages(groupId: groupId, page: page, recent: recent, size: size), completion: completion)
    }
}
