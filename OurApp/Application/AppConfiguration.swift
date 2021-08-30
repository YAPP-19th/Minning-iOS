//
//  AppConfiguration.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import Foundation

extension String {
    var asDefaultKey: String {
        #if PRODUCTION
        return self
        #else
        return "dev." + self
        #endif
    }
}

private enum AppConfigKey: String {
    case isFirstLaunch
    case isAutoLogin
    
    func getKey() -> String {
        switch self {
        case .isFirstLaunch:
            return "isFirstLaunch".asDefaultKey
        case .isAutoLogin:
            return "isAutoLogin".asDefaultKey
        }
    }
}

final class AppConfiguration {
    static let shared: AppConfiguration = AppConfiguration()
    
    var isFirstLaunch: Bool {
        get {
            return (UserDefaults.standard.value(forKey: AppConfigKey.isFirstLaunch.getKey()) as? Bool) ?? true
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: AppConfigKey.isFirstLaunch.getKey())
        }
    }
    
    var isAutoLogin: Bool {
        get {
            return (UserDefaults.standard.value(forKey: AppConfigKey.isAutoLogin.getKey()) as? Bool) ?? true
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: AppConfigKey.isAutoLogin.getKey())
        }
    }
    
    func kakaoAppKey() -> String? {
      return getKeyPlistValueBy("kKakaoAppKey")
    }
    
    func appName() -> String? {
        return getMainPlistValueBy("CFBundleName")
    }
}

extension AppConfiguration {
    private func getKeyPlistValueBy(_ key: String) -> String? {
        guard let path = Bundle.main.path(forResource: "Key", ofType: "plist") else {
            return nil
        }
        
        let dic = NSDictionary(contentsOfFile: path)
        return dic?.object(forKey: key) as? String
    }
    
    private func getMainPlistValueBy(_ key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
}
