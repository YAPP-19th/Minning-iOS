//
//  UserModel.swift
//  Minning
//
//  Created by denny on 2021/12/08.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public struct User {
    public let nickname: String
    public let email: String
    public let profileUrl: String
    
    public init(userModel: MyInfoModel) {
        self.nickname = userModel.nickname
        self.profileUrl = userModel.profileUrl
        self.email = userModel.email
    }
    
    public var profileFullUrl: URL? {
        var mainURLString: String = MinningAPIConstant.mainURL.absoluteString
        mainURLString.append(profileUrl)
        return URL(string: mainURLString)
    }
}
