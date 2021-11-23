//
//  MinningAPIConstant.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

struct MinningAPIConstant {
    static var authURL: URL {
        return mainURL.appendingPathComponent("/auth")
    }
    
    static var accountURL: URL {
        return mainURL.appendingPathComponent("/account")
    }
    
    static var groupURL: URL {
        return mainURL.appendingPathComponent("/group")
    }
    
    #if DEBUG
    static let mainURL = URL(string: "http://34.64.231.177:8000/api/v1")!
    #else
    static let mainURL = URL(string: "http://34.64.231.177:8000/api/v1")!
    #endif

}
