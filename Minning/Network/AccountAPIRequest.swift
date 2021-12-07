//
//  AccountAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public struct AccountAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case myInfo
        case toggleNotification
        case changePassword(password: String)
        case deleteUser
        
        var requestURL: URL {
            switch self {
            case .myInfo:
                return MinningAPIConstant.accountURL.appendingPathComponent("signup")
            case .toggleNotification:
                return MinningAPIConstant.accountURL
            case .changePassword:
                return MinningAPIConstant.accountURL
            case .deleteUser:
                return MinningAPIConstant.accountURL
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .deleteUser:
                return .delete
            case .myInfo, .toggleNotification:
                return .get
            case .changePassword:
                return .post
            }
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .changePassword(password):
                parameters["password"] = password
                return parameters
            case .myInfo, .toggleNotification, .deleteUser:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .changePassword:
                return .json
            case .myInfo, .toggleNotification, .deleteUser:
                return .url
            }
        }
    }
    
    public static func myInfo(completion: @escaping (Result<UserResponseModel, MinningAPIError>) -> Void) {
        perform(.myInfo, completion: completion)
    }
    
    public static func toggleNotification(completion: @escaping (Result<CommonAPIResponse, MinningAPIError>) -> Void) {
        perform(.toggleNotification, completion: completion)
    }
    
    public static func changePassword(password: String, completion: @escaping (Result<CommonAPIResponse, MinningAPIError>) -> Void) {
        perform(.changePassword(password: password), completion: completion)
    }
    
    public static func deleteUser(completion: @escaping (Result<CommonAPIResponse, MinningAPIError>) -> Void) {
        perform(.deleteUser, completion: completion)
    }
}
