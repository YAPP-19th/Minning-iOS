//
//  AuthAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem
import Pageboy

public struct LoginRequest: Codable {
    let email: String
    let nickname: String?
    let password: String?
    let socialType: SocialType
    
    enum SocialType: String, Codable {
        case kakao = "KAKAO"
        case apple = "APPLE"
        case email = "NORMAL"
    }
}

public struct LoginResponseModel: Codable {
    
}

public struct AuthAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case loginByEmail(request: LoginRequest)
        case checkVerificationCode(email: String, number: String)
        case logout
        
        var requestURL: URL {
            switch self {
            case .loginByEmail:
                return MinningAPIConstant.authURL.appendingPathComponent("login")
            case .checkVerificationCode:
                return MinningAPIConstant.authURL.appendingPathComponent("check").appendingPathComponent("number")
            case .logout:
                return MinningAPIConstant.authURL.appendingPathComponent("logout")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .loginByEmail, .checkVerificationCode:
                return .post
            case .logout:
                return .get
            }
        }
        
        var parameters: [String : Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .loginByEmail(request):
                parameters["email"] = request.email
                parameters["password"] = request.password
                return parameters
            case let .checkVerificationCode(email, number):
                parameters["email"] = email
                parameters["number"] = number
                return parameters
            case .logout:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .loginByEmail, .checkVerificationCode:
                return .json
            case .logout:
                return .url
            }
        }
    }
    
    public static func login(request: LoginRequest,
                             completion: @escaping (Result<LoginResponseModel, Error>) -> Void) {
        perform(.loginByEmail(request: request), completion: completion)
    }
    
    public static func checkVerificationCode(email: String, number: String,
                                             completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.checkVerificationCode(email: email, number: number), completion: completion)
    }
    
    public static func logout(completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.logout, completion: completion)
    }
}
