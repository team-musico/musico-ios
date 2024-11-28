//
//  PlaylistViewModel.swift
//  Musico
//
//  Created by dgsw07 on 11/25/24.
//
import Alamofire
import Foundation

class PlaylistViewModel: ObservableObject {
    @Published var playlist = ""
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String? = nil
    
    let serverUrl = ServerUrl.shared
    
    func createPlaylist(playlistName: String, completion: @escaping (Bool) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken"), !token.isEmpty else {
            self.errorMessage = "인증 토큰이 없습니다."
            completion(false)
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let url = serverUrl.getUrl(for: "/playlist")
        let params: [String: Any] = ["playlist": playlistName]
        
        AF.request(
            url,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.isSuccess = true
                    self.errorMessage = nil
                    print("플레이리스트 생성 성공")
                }
                completion(true)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isSuccess = false
                    self.errorMessage = error.localizedDescription
                    print("플레이리스트 생성 실패: \(error.localizedDescription)")
                }
                completion(false)
            }
        }
    }
}


