//
//
//import Alamofire
//import Foundation
//
//class NewSongViewModel : ObservableObject {
//    @Published var newSongs : [NewSong] = []
//    @Published var islogging = false
//    
//    let serverUrl = ServerUrl.shared
//    
//    func fetchNewSongs() {
//        let url = serverUrl.getUrl(for: "/songs/new-songs")
//        
//        AF.request(
//            url,
//            method: .get,
//            encoding: JSONEncoding.default
//        )
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: [NewSong].self ) { response in
//            switch response.result {
//            case .success(let result):
//                print("성공")
//                self.islogging = true
//                self.newSongs = result
//            case .failure(let error):
//                print("오류 발생: \(error.localizedDescription)")
//                self.islogging = false
//                if let data = response.data,
//                   let errorMessage = String(data: data, encoding: .utf8) {
//                    print("서버 오류 메시지: \(errorMessage)")
//                }
//            }
//        }
//    }
//}
//
