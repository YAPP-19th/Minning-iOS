//
//  AuthAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public enum SocialType: String, Codable {
    case kakao = "KAKAO"
    case apple = "APPLE"
    case email = "NORMAL"
}

public struct LoginRequest: Codable {
    let email: String
    let password: String
    let socialType: SocialType
}

public struct SignUpRequest: Codable {
    let email: String
    let nickname: String
    let password: String
    let socialType: SocialType
}

public struct SocialSignUpRequest: Codable {
    let email: String
    let nickname: String
    let socialType: SocialType
}

public struct SocialRequest: Codable {
//    let email: String
//    let id: Int64
    let socialType: SocialType
    let token: String
}

public struct AuthAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case signUp(request: SignUpRequest)
        case signUpSocial(request: SocialSignUpRequest)
        case socialCheck(request: SocialRequest)
        case loginByEmail(request: LoginRequest)
        case checkVerificationCode(email: String, number: String)
        case checkEmailExist(email: String)
        case send(email: String)
        case refreshToken
        case resetPassword(email: String, password: String)
        case logout
        
        var requestURL: URL {
            switch self {
            case .signUp:
                return MinningAPIConstant.authURL.appendingPathComponent("signup")
            case .socialCheck:
                return MinningAPIConstant.authURL.appendingPathComponent("social")
            case .signUpSocial:
                return MinningAPIConstant.authURL.appendingPathComponent("social").appendingPathComponent("signup")
            case .loginByEmail:
                return MinningAPIConstant.authURL.appendingPathComponent("login")
            case .send:
                return MinningAPIConstant.authURL.appendingPathComponent("send")
            case let .checkEmailExist(email):
                return MinningAPIConstant.authURL.appendingPathComponent("email").appendingPathComponent(email)
            case .checkVerificationCode:
                return MinningAPIConstant.authURL.appendingPathComponent("check").appendingPathComponent("number")
            case .refreshToken:
                return MinningAPIConstant.authURL.appendingPathComponent("reissue")
            case .resetPassword:
                return MinningAPIConstant.authURL.appendingPathComponent("set").appendingPathComponent("password")
            case .logout:
                return MinningAPIConstant.authURL.appendingPathComponent("logout")
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .signUp, .loginByEmail, .send, .checkVerificationCode, .refreshToken, .resetPassword, .socialCheck, .signUpSocial:
                return .post
            case .checkEmailExist, .logout:
                return .get
            }
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            switch self {
            case let .signUp(request):
                parameters["email"] = request.email
                parameters["password"] = request.password
                parameters["nickname"] = request.nickname
                parameters["socialType"] = request.socialType.rawValue
                return parameters
            case let .socialCheck(request):
//                parameters["email"] = request.email
//                parameters["id"] = request.id
                parameters["socialType"] = request.socialType.rawValue
                parameters["token"] = request.token
                return parameters
            case let.signUpSocial(request):
                parameters["email"] = request.email
                parameters["nickname"] = request.nickname
                parameters["socialType"] = request.socialType.rawValue
                return parameters
            case let .loginByEmail(request):
                parameters["email"] = request.email
                parameters["password"] = request.password
                parameters["socialType"] = request.socialType.rawValue
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
            case let .resetPassword(email, password):
                parameters["email"] = email
                parameters["password"] = password
                return parameters
            case .checkEmailExist, .logout:
                return nil
            }
        }
        
        var requestEncoding: RequestEncoding {
            switch self {
            case .signUp, .loginByEmail, .socialCheck, .signUpSocial, .send, .checkVerificationCode, .refreshToken, .resetPassword:
                return .json
            case .logout, .checkEmailExist:
                return .url
            }
        }
    }
    
    public static func login(request: LoginRequest,
                             completion: @escaping (Result<LoginResponseModel, Error>) -> Void) {
        perform(.loginByEmail(request: request), completion: completion)
    }
    
    public static func signUp(request: SignUpRequest,
                              completion: @escaping (Result<SignUpResponseModel, Error>) -> Void) {
        perform(.signUp(request: request), completion: completion)
    }
    
    public static func socialCheck(request: SocialRequest,
                                   completion: @escaping (Result<SignUpResponseModel, Error>) -> Void) {
        perform(.socialCheck(request: request), completion: completion)
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
    
    public static func resetPassword(email: String, password: String,
                                     completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.resetPassword(email: email, password: password), completion: completion)
    }
    
    public static func logout(completion: @escaping (Result<CommonAPIResponse, Error>) -> Void) {
        perform(.logout, completion: completion)
    }
    
    public static func checkEmailExist(email: String, completion: @escaping (Result<EmailExistResponseModel, Error>) -> Void) {
        perform(.checkEmailExist(email: email), completion: completion)
    }
}
