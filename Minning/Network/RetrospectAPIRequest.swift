//
//  RetrospectAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public struct RetrospectRequest {
    let content: String
    let date: String
    let image: UIImage?
    let routineId: Int64
}

public struct RoutineResultRequest {
    let date: String
    let result: String
    let routineId: Int64
}

public struct RetrospectAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case addRetrospect(request: RetrospectRequest)
        case modifyRetrospect(request: RetrospectRequest)
        case fetchSingleRetrospect(id: Int64)
        case deleteRetrospect(id: Int64)
        case fetchRetrospectByDate(date: String)
        case setRetrospectResult(request: RoutineResultRequest)
        
        var requestURL: URL {
            switch self {
            case .addRetrospect:
                return MinningAPIConstant.retrospectURL
            case .modifyRetrospect:
                return MinningAPIConstant.retrospectURL
            case let .fetchSingleRetrospect(id):
                return MinningAPIConstant.retrospectURL.appendingPathComponent("\(id)")
            case let .deleteRetrospect(id):
                return MinningAPIConstant.retrospectURL.appendingPathComponent("\(id)")
            case let .fetchRetrospectByDate(date):
                return MinningAPIConstant.retrospectURL.appendingPathComponent("list").appendingPathComponent("\(date)")
            case .setRetrospectResult:
                return MinningAPIConstant.retrospectURL.appendingPathComponent("result")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .addRetrospect:
                return .post
            case .modifyRetrospect:
                return .patch
            case .fetchSingleRetrospect:
                return .get
            case .deleteRetrospect:
                return .delete
            case .fetchRetrospectByDate:
                return .get
            case .setRetrospectResult:
                return .post
            }
        }
        
        var image: UIImage? {
            switch self {
            case let .addRetrospect(request):
                return request.image
            case let .modifyRetrospect(request):
                return request.image
            default:
                return nil
            }
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .addRetrospect(request):
                parameters["content"] = request.content
                parameters["date"] = request.date
                parameters["routineId"] = request.routineId
                return parameters
            case let .modifyRetrospect(request):
                parameters["content"] = request.content
                parameters["routineId"] = request.routineId
                return parameters
            case .fetchSingleRetrospect, .deleteRetrospect, .fetchRetrospectByDate:
                return nil
            case let .setRetrospectResult(request):
                parameters["date"] = request.date
                parameters["result"] = request.result
                parameters["routineId"] = request.routineId
                return parameters
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .addRetrospect, .modifyRetrospect:
                return .multipartFormData
            case .fetchSingleRetrospect, .deleteRetrospect, .fetchRetrospectByDate:
                return .url
            case .setRetrospectResult:
                return .json
            }
        }
    }
    
    public static func addRetrospect(request: RetrospectRequest,
                                     completion: @escaping (Result<RetrospectResponseModel, Error>) -> Void) {
        performMultipart(.addRetrospect(request: request), completion: completion)
    }
    
    public static func modifyRetrospect(request: RetrospectRequest,
                                        completion: @escaping (Result<RetrospectResponseModel, Error>) -> Void) {
        performMultipart(.modifyRetrospect(request: request), completion: completion)
    }
    
    public static func fetchSingleRetrospect(id: Int64,
                                             completion: @escaping (Result<RetrospectResponseModel, Error>) -> Void) {
        perform(.fetchSingleRetrospect(id: id), completion: completion)
    }
    
    public static func retrospectListByDate(date: String,
                                            completion: @escaping (Result<RetrospectListResponseModel, Error>) -> Void) {
        perform(.fetchRetrospectByDate(date: date), completion: completion)
    }
    
    public static func deleteRetrospect(id: Int64,
                                        completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.deleteRetrospect(id: id), completion: completion)
    }
    
    public static func setRetrospectResult(request: RoutineResultRequest,
                                           completion: @escaping (Result<RetrospectResponseModel, Error>) -> Void) {
        perform(.setRetrospectResult(request: request), completion: completion)
    }
}
