//
//  MinningAPIConstant.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

struct MinningAPIConstant {
    static var authURL: URL {
        var urlComponents = URLComponents()
        urlComponents.path = "/auth"
        return urlComponents.url!
    }
    
    static var groupURL: URL {
        var urlComponents = URLComponents()
        urlComponents.path = "/group"
        return urlComponents.url!
    }
    
    #if DEBUG
    static let mainURL = URL(string: "http://34.64.231.177:8000/api/v1")!
    #else
    static let mainURL = URL(string: "http://34.64.231.177:8000/api/v1")!
    #endif

}
