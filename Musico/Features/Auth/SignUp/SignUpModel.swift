//
//  SignUpModel.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import SwiftUI

struct SignUpModel: Encodable {
    var username: String
    var password: String
}

struct SignUpResponse: Decodable {
    var username: String
    var password: String
}


