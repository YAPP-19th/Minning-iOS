//
//  MinningAPIModel.swift
//  Minning
//
//  Created by denny on 2021/11/22.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public struct CommonAPIResponse: Codable {
    public let msg: String
    public let status: String
}

public struct LoginResponseModel: Codable {
    public let data: AccessTokenModel
    public let message: CommonAPIResponse
}

public struct RefreshTokenResponseModel: Codable {
    public let data: AccessTokenModel
    public let message: CommonAPIResponse
}

public struct AccessTokenModel: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case expiresIn = "accessTokenExpiresIn"
        case grantType
    }
    
    public let accessToken: String
    public let refreshToken: String
    public let expiresIn: Int64
    public let grantType: String
}
