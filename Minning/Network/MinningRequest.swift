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
    case multipartFormData
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .url:
            return URLEncoding.default
        case .urlQuery:
            return URLEncoding.queryString
        case .json:
            return JSONEncoding.default
        case .multipartFormData:
            return JSONEncoding.default // 사용하지 않는 값
        }
    }
}

public protocol APIRouteable: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var image: UIImage? { get }
    var parameters: [String: Any]? { get }
    var requestEncoding: RequestEncoding { get }
}

public protocol UploadRouteable: UploadConvertible {
    
}

protocol MinningAPIRequestable {
    associatedtype RequestType: APIRouteable
    static func perform<T: Decodable>(_ request: RequestType,
                                      isCustomError: Bool,
                                      completion: @escaping (Result<T, MinningAPIError>) -> Void)
    static func performMultipart<T: Decodable>(_ request: RequestType,
                                               isCustomError: Bool,
                                               completion: @escaping (Result<T, MinningAPIError>) -> Void)
}

extension MinningAPIRequestable {
    static func perform<T: Decodable>(_ request: RequestType,
                                      isCustomError: Bool = false,
                                      completion: @escaping (Result<T, MinningAPIError>) -> Void) {
        DebugLog("Request URL: \(request.requestURL.absoluteString)")
        DebugLog("Request Header: \(request.urlRequest?.allHTTPHeaderFields.debugDescription ?? "nil")")
        DebugLog("Request Parameters: \(request.parameters.debugDescription)")
        
        let dataRequest = AF.request(request)
        dataRequest
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: AFDataResponse<T>) in
                let responseData = response.data ?? Data()
                let string = String(data: responseData, encoding: .utf8)
                
                DebugLog("ResponseString: \(string ?? "nil")")
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    if isCustomError {
                        completion(.failure(.custom(error: error, customValue: responseData)))
                    } else {
                        completion(.failure(.normal(error: error)))
                    }
                }
            }
    }
    
    static func performMultipart<T: Decodable>(_ request: RequestType,
                                               isCustomError: Bool = false,
                                               completion: @escaping (Result<T, MinningAPIError>) -> Void) {
        let multipartFormData: MultipartFormData = MultipartFormData()
        if let parameters = request.parameters {
            parameters.forEach { parameter in
                if let data = parameter.value as? Data {
                    multipartFormData.append(data, withName: parameter.key)
                }
            }
        }
        
        if let image = request.image,
            let imageData = image.jpegData(compressionQuality: 1) {
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }
        
        let newHeaders = [MinningHeader.accept(value: "application/json"),
                          MinningHeader.contentType(value: "application/json"),
                          MinningHeader.authorization]
        
        var headers: HTTPHeaders = HTTPHeaders()
        newHeaders.forEach { newHeader in
            headers.add(HTTPHeader(name: newHeader.key, value: newHeader.value))
        }
        
        let uploadRequest = AF.upload(multipartFormData: multipartFormData,
                                      to: request.requestURL,
                                      method: request.httpMethod,
                                      headers: headers)
        
        DebugLog("Request URL: \(request.requestURL.absoluteString)")
        DebugLog("Request Header: \(request.urlRequest?.allHTTPHeaderFields.debugDescription ?? "nil")")
        
        uploadRequest
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: AFDataResponse<T>) in
                let responseData = response.data ?? Data()
                let string = String(data: responseData, encoding: .utf8)
                
                DebugLog("Repsonse: \(string ?? "")")
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    if isCustomError {
                        completion(.failure(.custom(error: error, customValue: responseData)))
                    } else {
                        completion(.failure(.normal(error: error)))
                    }
                }
            }
    }
}

public extension APIRouteable {
    var baseURL: URL {
        #if DEBUG
        return MinningAPIConstant.mainURL
        #else
        return MinningAPIConstant.mainURL
        #endif
    }
    
    var accessToken: String {
        return TokenManager.shared.getAccessToken() ?? ""
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let newHeaders = [MinningHeader.accept(value: "application/json"),
                          MinningHeader.contentType(value: "application/json")]

        newHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        request.timeoutInterval = 60
        return try requestEncoding.parameterEncoding.encode(request, with: parameters)
    }
}
