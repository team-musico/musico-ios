import Alamofire
import Foundation
import AVKit

class ChartViewModel: ObservableObject {
    @Published var chart: [Song] = []
    @Published var newSongs: [Song] = []
    @Published var islogging = false
    @Published var searchSongs: [Song] = []
    @Published var search = ""
    @Published var player: AVPlayer?
    @Published var isPlaying = false
    @Published var videoId: String = ""
    @Published var currentVideoId: String = "" 
    
    let serverUrl = ServerUrl.shared
    
    func fetchChart() {
        let url = serverUrl.getUrl(for: "/songs/chart")
        
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [Song].self) { response in
            switch response.result {
            case .success(let result):
                self.islogging = true
                self.chart = result
            case .failure(let error):
                self.islogging = false
                print("오류 발생: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNewSongs() {
        let url = serverUrl.getUrl(for: "/songs/new-songs")
        
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [Song].self) { response in
            switch response.result {
            case .success(let result):
                self.islogging = true
                self.newSongs = result
            case .failure(let error):
                self.islogging = false
                print("오류 발생: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSongs(search: String) {
        self.searchSongs = []
        
        let url = serverUrl.getUrl(for: "/songs/search?q=\(search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Song].self) { response in
                switch response.result {
                case .success(let songs):
                    DispatchQueue.main.async {
                        self.searchSongs = songs
                    }
                case .failure(let error):
                    print("오류 발생: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchVideoId(for song: Song) {
          let query = "\(song.title) - \(song.artists.first?.artistName ?? "")"
          let url = "https://search.musico.kr/"
          let params: [String: Any] = ["query": query]

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
              .validate(statusCode: 200..<300)
              .response { response in
                  switch response.result {
                  case .success(let data):
                      if let videoIds = try? JSONDecoder().decode([String].self, from: data!) {
                          DispatchQueue.main.async {
                              if let index = self.searchSongs.firstIndex(where: { $0.trackId == song.trackId }) {
                                  self.searchSongs[index].videoId = videoIds
                                  // videoId 업데이트 후 현재 videoId를 설정
                                  self.currentVideoId = videoIds.first ?? ""
                              }
                          }
                      }
                  case .failure(let error):
                      print("오류 발생: \(error.localizedDescription)")
                  }
              }
      }
  }

