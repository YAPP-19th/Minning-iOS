//
//  MinningRequest.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public enum Method {
    case get
    case post
    case delete
    case put
    case patch
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        case .put:
            return .put
        case .patch:
            return .patch
        }
    }
}

public enum RequestEncoding {
    case url
    case urlQuery
    case json
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .url:
            return URLEncoding.default
        case .urlQuery:
            return URLEncoding.queryString
        case .json:
            return JSONEncoding.default
        }
    }
}

public protocol APIRouteable: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String : Any]? { get }
    var requestEncoding: RequestEncoding { get }
}

protocol MinningAPIRequestable {
    associatedtype RequestType: APIRouteable
    static func perform<T: Decodable>(_ request: RequestType,
                                      completion: @escaping (Result<T, Error>) -> Void)
}

extension MinningAPIRequestable {
    static func perform<T: Decodable>(_ request: RequestType,
                                      completion: @escaping (Result<T, Error>) -> Void) {
        let dataRequest = AF.request(request)
        dataRequest
            .validate(statusCode: 200..<300)
            .responseDecodable{ (response: AFDataResponse<T>) in
                let responseData = response.data ?? Data()
                let string = String(data: responseData, encoding: .utf8)
                
                DebugLog("Repsonse: \(string ?? "")")
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

extension APIRouteable {
    public var baseURL: URL {
        #if DEBUG
        return MinningAPIConstant.mainURL
        #else
        return MinningAPIConstant.mainURL
        #endif
    }
    
    public var accessToken: String {
        return ""
    }
    
    public func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue(accessToken, forHTTPHeaderField: "AccessToken")
        
        let newHeaders = [MinningHeader.accept(value: "application/json"),
                          MinningHeader.contentType(value: "application/json")]

        newHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        request.timeoutInterval = 60
        return try requestEncoding.parameterEncoding.encode(request, with: parameters)
    }
}
