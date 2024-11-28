//
//  File.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import Foundation

struct ServerUrl {
    var baseUrl = "https://api.musico.kr"
    
    func getUrl(for endpoint: String) -> String {
        return baseUrl + endpoint
    }
    
    static let shared = ServerUrl()
    
    private init() {}
}
