


import Foundation
import Alamofire

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isSecure: Bool = true
    @Published var loginerrorMessage: String?
    let serverUrl = ServerUrl.shared
    
    var isLoginDisabled: Bool {
        username.isEmpty || password.isEmpty
    }
    func login(completion: @escaping (Bool) -> Void) {
        let url = serverUrl.getUrl(for: "/auth/login")
        
        AF.request(
            url,
            method: .post,
            parameters: LoginModel(username: username, password: password),
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let tokenResponse):
                UserDefaults.standard.setValue(tokenResponse.accessToken, forKey: "accessToken")
                UserDefaults.standard.setValue(tokenResponse.refreshToken, forKey: "refreshToken")
                completion(true)
            case .failure(let error):
                self.loginerrorMessage = error.localizedDescription
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
