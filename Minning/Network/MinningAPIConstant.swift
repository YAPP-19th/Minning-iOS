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
    
    static var retrospectURL: URL {
        return mainURL.appendingPathComponent("/retrospect")
    }
    
    static var reportURL: URL {
        return mainURL.appendingPathComponent("/report")
    }
    
    static var sayingURL: URL {
        return mainURL.appendingPathComponent("/saying")
    }
    
    static var missionURL: URL {
        return mainURL.appendingPathComponent("/mission")
    }
    
    static var captureURL: URL {
        return mainURL.appendingPathComponent("/capture")
    }
    
    static var routineURL: URL {
        return mainURL.appendingPathComponent("/routine")
    }
    
    static var noticeURL: URL {
        return mainURL.appendingPathComponent("/notice")
    }
    
    static var groupURL: URL {
        return mainURL.appendingPathComponent("/group")
    }
    
    #if DEBUG
    static let mainURL = URL(string: "http://34.64.188.164:8000/api/v1")!
    #else
    static let mainURL = URL(string: "http://34.64.188.164:8000/api/v1")!
    #endif

}
