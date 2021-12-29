//
//  RoutineAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem
import Pageboy

public struct RoutineRequest {
    let category: RoutineCategory
    let days: [Day]
    let goal: String
    let startTime: String
    let title: String
}

public struct RoutineAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case addRoutine(request: RoutineRequest)
        case fetchSingleRoutine(id: Int64)
        case deleteRoutine(id: Int64)
        case modifyRoutine(id: Int64, request: RoutineRequest)
        case fetchPercentPerWeek(date: String)
        case fetchAllByDay(date: String)
        case modifyRoutineOrder(day: Day, ids: [Int64])
        
        var requestURL: URL {
            switch self {
            case .addRoutine:
                return MinningAPIConstant.routineURL.appendingPathComponent("")
            case let .fetchSingleRoutine(id):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(id)")
            case let .deleteRoutine(id):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(id)")
            case let .modifyRoutine(id, _):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(id)")
            case let .fetchPercentPerWeek(date):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(date)").appendingPathComponent("rate")
            case let .fetchAllByDay(date):
                return MinningAPIConstant.routineURL
                    .appendingPathComponent("day")
                    .appendingPathComponent("\(date)")
            case let .modifyRoutineOrder(day, _):
                return MinningAPIConstant.routineURL.appendingPathComponent("sequence").appendingPathComponent("\(day.rawValue)")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .addRoutine:
                return .post
            case .deleteRoutine:
                return .delete
            case .fetchSingleRoutine, .fetchPercentPerWeek, .fetchAllByDay:
                return .get
            case .modifyRoutine, .modifyRoutineOrder:
                return .patch
            }
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .addRoutine(request):
                parameters["category"] = request.category.rawValue
                parameters["days"] = request.days.map { $0.rawValue }
                parameters["goal"] = request.goal
                parameters["startTime"] = request.startTime
                parameters["title"] = request.title
                return parameters
            case let .modifyRoutine(_, request):
                parameters["category"] = request.category.title
                parameters["days"] = request.days.map { $0.rawValue }
                parameters["goal"] = request.goal
                parameters["startTime"] = request.startTime
                parameters["title"] = request.title
                return parameters
            case let .modifyRoutineOrder(_, ids):
                parameters["sequence"] = ids
                return parameters
            case .fetchSingleRoutine, .deleteRoutine, .fetchPercentPerWeek, .fetchAllByDay:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .fetchSingleRoutine, .deleteRoutine, .fetchPercentPerWeek, .fetchAllByDay:
                return .url
            case .addRoutine, .modifyRoutine, .modifyRoutineOrder:
                return .json
            }
        }
    }
    
    public static func addRoutine(request: RoutineRequest,
                                  completion: @escaping (Result<RoutineResponseModel, MinningAPIError>) -> Void) {
        perform(.addRoutine(request: request), completion: completion)
    }
    
    public static func modifyRoutine(routineId: Int64,
                                     request: RoutineRequest,
                                     completion: @escaping (Result<RoutineResponseModel, MinningAPIError>) -> Void) {
        perform(.modifyRoutine(id: routineId, request: request), completion: completion)
    }
    
    public static func fetchSingleRoutine(routineId: Int64,
                                          completion: @escaping (Result<RoutineResponseModel, MinningAPIError>) -> Void) {
        perform(.fetchSingleRoutine(id: routineId), completion: completion)
    }
    
    public static func deleteRoutine(routineId: Int64,
                                     completion: @escaping (Result<CommonAPIResponse, MinningAPIError>) -> Void) {
        perform(.deleteRoutine(id: routineId), completion: completion)
    }
    
    public static func getRoutinePercentPerWeek(date: String, completion: @escaping (Result<RoutinePercentResponseModel, MinningAPIError>) -> Void) {
        perform(.fetchPercentPerWeek(date: date), completion: completion)
    }
    
    public static func routineListByDay(date: String, completion: @escaping (Result<RoutineListResponseModel, MinningAPIError>) -> Void) {
        perform(.fetchAllByDay(date: date), completion: completion)
    }
    
    public static func modifyRoutineOrderByDay(day: Day,
                                               routineIds: [Int64],
                                               completion: @escaping (Result<RoutineListResponseModel, MinningAPIError>) -> Void) {
        perform(.modifyRoutineOrder(day: day, ids: routineIds), completion: completion)
    }
}
