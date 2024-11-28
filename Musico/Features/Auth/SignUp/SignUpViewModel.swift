//
//  SignUpViewModel.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import Foundation
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var code: String = ""
    @Published var password: String = ""
    
    let serverUrl = ServerUrl.shared
    @Published var isSecure: Bool = true
    @Published var signupErrorMessage: String? = nil
    @Published var isTimerRunning: Bool = false
    @Published var remainingTime: Int = 0
    
    func startCountdown() {
        remainingTime = 300
        isTimerRunning = true
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            DispatchQueue.main.async {
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    timer.invalidate()
                    self.isTimerRunning = false
                }
            }
        }
    }
    
    var isSignupDisabled: Bool {
        username.isEmpty || password.isEmpty
    }
    
    func signup() async -> Bool {
        let url = serverUrl.getUrl(for: "/auth/signup")
        
        return await withCheckedContinuation { continuation in
            AF.request(url,method: .post,parameters: SignUpModel(username: username, password: password),encoder: JSONParameterEncoder.default)
                .validate()
                .responseDecodable(of: SignUpResponse.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        print("회원가입 성공: \(responseData)")
                        self.signupErrorMessage = "예상치 못한 오류가 발생했습니다."
                        continuation.resume(returning: false)
                    case .failure(_):
                        if let data = response.data, let serverMessage = String(data: data, encoding: .utf8) {
                            print("서버 오류 메시지: \(serverMessage)")
                        }
                        self.signupErrorMessage = nil
                        continuation.resume(returning: true)
                    }
                }
        }
    }
    
}
