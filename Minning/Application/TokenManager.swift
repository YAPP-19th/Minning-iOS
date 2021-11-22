//
//  TokenManager.swift
//  Minning
//
//  Created by denny on 2021/11/22.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public class TokenManager {
    public static let shared: TokenManager = TokenManager()
    private init() { }
    
    public func getAccessToken() -> String {
        return ""
    }
    
    public func getRefreshToken() -> String {
        return ""
    }
}
