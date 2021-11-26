//
//  SayingAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public struct SayingAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case checkTodaySaying
        case compareSayingContent(content: String, sayingId: Int64)
        case getTodaySaying
        
        var requestURL: URL {
            switch self {
            case .getTodaySaying:
                return MinningAPIConstant.sayingURL.appendingPathComponent("today")
            case .checkTodaySaying:
                return MinningAPIConstant.sayingURL.appendingPathComponent("check")
            case .compareSayingContent:
                return MinningAPIConstant.sayingURL.appendingPathComponent("check")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getTodaySaying, .checkTodaySaying:
                return .get
            case .compareSayingContent:
                return .post
            }
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .compareSayingContent(content, id):
                parameters["content"] = content
                parameters["id"] = id
                return parameters
            case .getTodaySaying, .checkTodaySaying:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .getTodaySaying, .checkTodaySaying:
                return .url
            case .compareSayingContent:
                return .json
            }
        }
    }
    
    public static func checkTodaySaying(completion: @escaping (Result<TodaySayingCheckResponseModel, Error>) -> Void) {
        perform(.checkTodaySaying, completion: completion)
    }
    
    public static func getTodaySaying(completion: @escaping (Result<SayingResponseModel, Error>) -> Void) {
        perform(.getTodaySaying, completion: completion)
    }
    
    public static func compareSaying(content: String,
                                     sayingId: Int64,
                                     completion: @escaping (Result<SayingCompareResponseModel, Error>) -> Void) {
        perform(.compareSayingContent(content: content, sayingId: sayingId), completion: completion)
    }
}

