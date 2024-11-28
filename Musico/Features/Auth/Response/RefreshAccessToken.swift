import Foundation
import Alamofire

let serverUrl = ServerUrl.shared

class RefreshAccessToken {
    static let shared = RefreshAccessToken()

    private init() {}

    func reissue(completion: @escaping (Bool) -> Void) {
        let url = serverUrl.getUrl(for: "/auth/refresh")

        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            print("Refresh token이 존재하지 않습니다.")
            completion(false)
            return
        }

        print(refreshToken)

        let parameter: [String: Any] = [
            "refreshToken": refreshToken
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let tokenResponse): 
                UserDefaults.standard.set(tokenResponse.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(tokenResponse.refreshToken, forKey: "refreshToken")
                print("토큰재발급 성공")
                completion(true)

            case .failure(let error):
                print("토큰 발급 실패: \(error.localizedDescription)")

                if let httpResponse = response.response {
                    print("응답 코드: \(httpResponse.statusCode)")
                }

                if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(errorMessage)")
                }

                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")

                completion(false)
            }
        }
    }
}
