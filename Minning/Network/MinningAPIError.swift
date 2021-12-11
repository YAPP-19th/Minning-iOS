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
    case custom(error: Error, customValue: Data?)
    
    public var defaultError: Error {
        switch self {
        case .normal(let error):
            return error
        case .custom(let error, _):
            return error
        }
    }
    
    public var customValue: Data? {
        switch self {
        case .normal:
            return nil
        case .custom(_, let customValue):
            return customValue
        }
    }
}
