//
//  MinningAPIError.swift
//  Minning
//
//  Created by denny on 2021/12/07.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Darwin

public enum MinningAPIError: Error {
    case normal(error: Error)
    case defaultData(error: Error, status: String, msg: String)
    case custom(error: Error, customValue: Data?)
    
    public var defaultError: Error {
        switch self {
        case .normal(let error):
            return error
        case .defaultData(let error, _, _):
            return error
        case .custom(let error, _):
            return error
        }
    }
    
    public var status: String? {
        switch self {
        case .defaultData(_, let status, _):
            return status
        default:
            return nil
        }
    }
    
    public var msg: String? {
        switch self {
        case .defaultData(_, _, let msg):
            return msg
        default:
            return nil
        }
    }
    
    public var customValue: Data? {
        switch self {
        case .normal, .defaultData:
            return nil
        case .custom(_, let customValue):
            return customValue
        }
    }
}
