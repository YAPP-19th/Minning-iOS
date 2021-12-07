//
//  TokenManager.swift
//  Minning
//
//  Created by denny on 2021/11/22.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

public class TokenManager {
    public static let shared: TokenManager = TokenManager()
    
    public static let accessTokenKey: String = "AccessToken"
    public static let refreshTokenKey: String = "RefreshToken"
    public static let accessTokenExpiredKey: String = "AccessTokenExpiredAt"
    public static let deviceFCMTokenKey: String = "DeviceFCMTokenKey"
    
    private init() { }
    
    public func getAccessToken() -> String? {
        return KeychainManager.shared.getString(TokenManager.accessTokenKey)
    }
    
    public func setAccessToken(token: String) -> Bool {
        return KeychainManager.shared.set(token, forKey: TokenManager.accessTokenKey)
    }
    
    public func getRefreshToken() -> String? {
        return KeychainManager.shared.getString(TokenManager.refreshTokenKey)
    }
    
    public func setRefreshToken(token: String) -> Bool {
        return KeychainManager.shared.set(token, forKey: TokenManager.refreshTokenKey)
    }
    
    public func setAccessTokenExpiredDate(expiredAt: Date) -> Bool {
        return KeychainManager.shared.set(expiredAt.convertToString(), forKey: TokenManager.accessTokenExpiredKey)
    }
    
    public func getAccessTokenExpiredDate() -> Date? {
        return KeychainManager.shared.getString(TokenManager.accessTokenExpiredKey)?.convertToDate()
    }
    
    public func deleteAllTokenData() -> Bool {
        let atResult = KeychainManager.shared.delete(TokenManager.accessTokenKey)
        let ateResult = KeychainManager.shared.delete(TokenManager.accessTokenExpiredKey)
        let rtResult = KeychainManager.shared.delete(TokenManager.refreshTokenKey)
        
        return atResult && ateResult && rtResult
    }
    
    public func checkAccessTokenExpired() -> Bool {
        if let expiredAt = getAccessTokenExpiredDate() {
            return expiredAt < Date()
        } else {
            return false
        }
    }
    
    public func getFCMToken() -> String? {
        return KeychainManager.shared.getString(TokenManager.deviceFCMTokenKey)
    }
    
    public func setFCMToken(token: String) -> Bool {
        return KeychainManager.shared.set(token, forKey: TokenManager.deviceFCMTokenKey)
    }
}
