import SwiftUI
import YouTubePlayerKit

struct VideoView: View {
    @StateObject var viewModel = ChartViewModel()
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("검색어 입력", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.fetchSongs(search: searchText)
                }) {
                    Text("검색")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            List(viewModel.searchSongs) { song in
                VStack(alignment: .leading) {
                    Text(song.title)
                    Text(song.artists.first?.artistName ?? "")
                    Button("영상 보기") {
                        viewModel.currentVideoId.removeAll()
                        if let videoId = song.videoId?.first {
                            viewModel.currentVideoId = videoId
                        } else {
                            viewModel.fetchVideoId(for: song)
                        }
                    }
                }
            }
            ZStack {
                if !viewModel.currentVideoId.isEmpty {
                    let youTubePlayer = YouTubePlayer(
                        source: .video(id: viewModel.currentVideoId),
                        configuration: .init(autoPlay: true)
                    )
                    
                    YouTubePlayerView(youTubePlayer) { state in
                        switch state {
                        case .idle:
                            ProgressView()
                        case .ready:
                            EmptyView()
                        case .error:
                            Label(
                                "An error occurred.",
                                systemImage: "xmark.circle.fill"
                            )
                            .foregroundStyle(.red)
                        }
                    }
                    .frame(height:0)
                }
                
                Spacer()
            }
            .zIndex(-1)
        }
        .padding()
    }
}

#Preview {
    VideoView()
}
