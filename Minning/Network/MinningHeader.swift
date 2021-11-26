//
//  MinningHeader.swift
//  Minning
//
//  Created by denny on 2021/11/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import Foundation

public struct MinningConstants {
    public static let hostName = MinningProperty.apiRouteURL
}

public enum MinningHeader {
    case authorization
    case accept(value: String)
    case contentType(value: String)
    case custom(key: String, value: String)
    
    public var key: String {
        switch self {
        case .authorization:
            return "authorization"
        case .accept:
            return "Accept"
        case .contentType:
            return "Content-Type"
        case .custom(let key, _):
            return key
        }
    }
    
    public var value: String {
        switch self {
        case .authorization:
            return "" // Token 관리 모듈 필요
        case .accept(let value):
            return value
        case .contentType(let value):
            return value
        case .custom(_, let value):
            return value
        }
    }
}
