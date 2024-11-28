//
//  MusicoApp.swift
//  Musico
//
//  Created by dgsw07 on 11/24/24.
//

import SwiftUI


@main
struct MusicoApp: App {
    @AppStorage("accessToken")
    private var accessToken: String?
    @StateObject private var loginVM = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if accessToken == nil {
                    LoginView()
                } else {
                    ChartView()
                        .environmentObject(loginVM)
                }
            }
        }
    }
}
