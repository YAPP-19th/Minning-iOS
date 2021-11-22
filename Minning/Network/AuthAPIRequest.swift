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

public struct AuthAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case loginByEmail(request: LoginRequest)
        case checkVerificationCode(email: String, number: String)
        case send(email: String)
        case refreshToken
        case logout
        
        var requestURL: URL {
            switch self {
            case .loginByEmail:
                return MinningAPIConstant.authURL.appendingPathComponent("login")
            case .send:
                return MinningAPIConstant.authURL.appendingPathComponent("send")
            case .checkVerificationCode:
                return MinningAPIConstant.authURL.appendingPathComponent("check").appendingPathComponent("number")
            case .refreshToken:
                return MinningAPIConstant.authURL.appendingPathComponent("reissue")
            case .logout:
                return MinningAPIConstant.authURL.appendingPathComponent("logout")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .loginByEmail, .send, .checkVerificationCode, .refreshToken:
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
            case let .send(email):
                parameters["email"] = email
                return parameters
            case let .checkVerificationCode(email, number):
                parameters["email"] = email
                parameters["number"] = number
                return parameters
            case .refreshToken:
                parameters["refreshToken"] = TokenManager.shared.getRefreshToken()
                return parameters
            case .logout:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .loginByEmail, .send, .checkVerificationCode, .refreshToken:
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
    
    public static func send(email: String, completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.send(email: email), completion: completion)
    }
    
    public static func checkVerificationCode(email: String, number: String,
                                             completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.checkVerificationCode(email: email, number: number), completion: completion)
    }
    
    public static func refreshToken(completion: @escaping (Result<RefreshTokenResponseModel, Error>) -> Void) {
        perform(.refreshToken, completion: completion)
    }
    
    public static func logout(completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.logout, completion: completion)
    }
}
