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
        case fetchPercentPerWeek
        case fetchAllByDay(day: Day)
        case modifyRoutineOrder(day: Day, ids: [Int64])
        
        var requestURL: URL {
            switch self {
            case .addRoutine:
                return MinningAPIConstant.routineURL
            case let .fetchSingleRoutine(id):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(id)")
            case let .deleteRoutine(id):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(id)")
            case let .modifyRoutine(id, _):
                return MinningAPIConstant.routineURL.appendingPathComponent("\(id)")
            case .fetchPercentPerWeek:
                return MinningAPIConstant.routineURL.appendingPathComponent("\(Day.mon.rawValue)").appendingPathComponent("rate")
            case let .fetchAllByDay(day):
                return MinningAPIConstant.routineURL.appendingPathComponent("day").appendingPathComponent("\(day.rawValue)")
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
                parameters["category"] = request.category.title
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
                                  completion: @escaping (Result<RoutineResponseModel, Error>) -> Void) {
        perform(.addRoutine(request: request), completion: completion)
    }
    
    public static func modifyRoutine(routineId: Int64,
                                     request: RoutineRequest,
                                     completion: @escaping (Result<RoutineResponseModel, Error>) -> Void) {
        perform(.modifyRoutine(id: routineId, request: request), completion: completion)
    }
    
    public static func fetchSingleRoutine(routineId: Int64,
                                          completion: @escaping (Result<RoutineResponseModel, Error>) -> Void) {
        perform(.fetchSingleRoutine(id: routineId), completion: completion)
    }
    
    public static func deleteRoutine(routineId: Int64,
                                     completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.deleteRoutine(id: routineId), completion: completion)
    }
    
    public static func getRoutinePercentPerWeek(completion: @escaping (Result<RoutinePercentResponseModel, Error>) -> Void) {
        perform(.fetchPercentPerWeek, completion: completion)
    }
    
    public static func routineListByDay(day: Day, completion: @escaping (Result<RoutineListResponseModel, Error>) -> Void) {
        perform(.fetchAllByDay(day: day), completion: completion)
    }
    
    public static func modifyRoutineOrderByDay(day: Day,
                                               routineIds: [Int64],
                                               completion: @escaping (Result<RoutineListResponseModel, Error>) -> Void) {
        perform(.modifyRoutineOrder(day: day, ids: routineIds), completion: completion)
    }
}
