//
//  TokenResponse.swift
//  Musico
//
//  Created by dgsw07 on 11/22/24.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}

struct RefreshToken : Codable {
    let refreshToken: String
}
