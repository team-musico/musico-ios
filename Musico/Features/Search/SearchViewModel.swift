//
//  SearchViewModel.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//
import Alamofire
import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchSongs: [SearchSong] = []
    @Published var search = ""

    let serverUrl = ServerUrl.shared

    
    func fetchSongs(search: String) {
        
        self.searchSongs = []
        
        let url = serverUrl.getUrl(for: "/songs/search?q=\(search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")

        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [SearchSong].self) { response in
                switch response.result {
                case .success(let songs):
                    print("성공")
                    DispatchQueue.main.async {
                        self.searchSongs = songs 
                    }
                    
                case .failure(let error):
                    print("오류 발생: \(error.localizedDescription)")
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("서버 오류 메시지: \(errorMessage)")
                    }
                }
            }
    }
}
