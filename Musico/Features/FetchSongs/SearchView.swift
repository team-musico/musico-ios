import SwiftUI
import YouTubePlayerKit
struct SearchView: View {
    @StateObject var viewModel = ChartViewModel()
    @EnvironmentObject var musicPlayer: MusicManager
    @State private var selectedSong: Song? = nil
    @State private var searchClick = false
    @State private var showNilSearch = false
    @State private var sideBarOn = false
    @State private var expandSheet = false
    @State private var showAnimation = false
    @Namespace private var animation
    
    
    var body: some View {
        VStack {
            Header(sideBarOn: $sideBarOn)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    HStack {
                        Spacer().frame(width: 10)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.3)
                            .foregroundColor(.secondary.opacity(0.9))
                            .frame(width: 370, height: 46, alignment: .trailing)
                            .padding(.top, 10)
                            .overlay {
                                HStack {
                                    TextField("제목을 입력해주세요", text: $viewModel.search)
                                        .padding(.top, 10)
                                        .padding(.leading, 10)
//                                        .onChange(of: viewModel.search) { search in
//                                            searchClick = false
//                                            showNilSearch = false
//                                            if !viewModel.search.isEmpty {
//                                                viewModel.fetchSongs(search: viewModel.search)
//                                                searchClick = true
//                                                
//                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                                    if viewModel.searchSongs.isEmpty {
//                                                        showNilSearch = true
//                                                    }
//                                                }
//                                            }
//                                        }
                                    
                                    Button {
                                        
                                        if !viewModel.search.isEmpty {
                                            if !viewModel.searchHistory.contains(viewModel.search) {
                                                viewModel.searchHistory.insert(viewModel.search, at: 0)
                                            }
                                            
                                            viewModel.fetchSongs(search: viewModel.search)
                                            searchClick = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                if viewModel.searchSongs.isEmpty {
                                                    showNilSearch = true
                                                }
                                            }
                                        }
                                        
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                            .padding(.top, 10)
                                            .padding(.trailing, 10)
                                    }
                                    .foregroundColor(.secondary.opacity(0.5))                  
                                }
                            }
                    }
                    
                    if viewModel.search.isEmpty {
                        Spacer().frame(height: 230)
                        HStack {
                            Spacer()
                            Text("노래 제목을 입력해주세요")
                            if !viewModel.searchHistory.isEmpty {
                                       VStack(alignment: .leading) {
                                           Text("최근 검색")
                                               .font(.headline)
                                               .padding(.leading)

                                           ForEach(viewModel.searchHistory, id: \.self) { history in
                                               Text(history)
                                                   .padding()
                                                   .onTapGesture {
                                                       viewModel.search = history
                                                       viewModel.fetchSongs(search: history)
                                                   }
                                           }
                                       }
                                   }
                            Spacer()
                        }
                    } else if searchClick {
                        if showNilSearch && viewModel.searchSongs.isEmpty {
                            Spacer().frame(height: 230)
                            Text("검색 결과가 없습니다.")
                                .padding(.leading, 114)
                        } else if !viewModel.searchSongs.isEmpty {
                            HStack {
                                Text("\(viewModel.search)의 검색결과")
                                    .font(.system(size: 21).weight(.medium))
                                Text("\(viewModel.searchSongs.count)건")
                                    .foregroundColor(.indigo)
                                    .font(.system(size: 21).weight(.bold))
                            }
                            .padding(.leading, 17)
                            .padding(.top, 25)
                            
                            ForEach(viewModel.searchSongs) { song in
                                VStack(alignment: .leading) {
                                    HStack(alignment: .center) {
                                        AsyncImage(url: URL(string: song.albumArt ?? "")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 65, height: 65)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding(.leading, 10)
                                        } placeholder: {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray)
                                                .frame(width: 65, height: 65)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text(song.title)
                                                .frame(width: 220,alignment: .leading)
                                                .font(.system(size: 16, weight: .semibold))
                                                .lineLimit(1)
                                            Spacer().frame(height: 10)
                                            Text(song.artists.map { $0.artistName }.joined(separator: ", "))
                                                .foregroundColor(.secondary)
                                                .font(.system(size: 14))
                                                .lineLimit(1)
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.leading, 7)
                                        Spacer()
                                        if selectedSong == song {
                                            AnimationView()
                                                .frame(width: 10, height: 10, alignment: .trailing)
                                        }
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .onTapGesture {
                                    selectedSong = song
                                    viewModel.currentVideoId = ""
                                    if let videoId = song.videoId?.first {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            viewModel.currentVideoId = videoId
                                        }
                                    } else {
                                        viewModel.fetchVideoId(for: song)
                                    }
                                    showAnimation = true
                                }
                            }
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
                            EmptyView()
                        case .ready:
                            EmptyView()
                        case .error:
                            Label(
                                "재생할 수 없는 곡입니다.",
                                systemImage: "xmark.circle.fill"
                            )
                            .foregroundStyle(.red)
                        }
                    }
                }
                Spacer()
            }.frame(height:0)
            if selectedSong != nil {
                ZStack {
                    Rectangle()
                        .fill(.ultraThickMaterial)
                        .ignoresSafeArea()
                        .frame(height: 70)
                        .overlay {
                            MusicInfo(expandSheet: $expandSheet, animation: animation, selectedSong: selectedSong)
                                .onTapGesture {
                                    expandSheet = true
                                }
                        }
                        .matchedGeometryEffect(id: "BGVIEW", in: animation)
                }
            }
        }
        .overlay {
            if expandSheet {
                ExpandBottomeSheet(expandSheet: $expandSheet, animation: animation, song: selectedSong)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
    }
}


#Preview {
    SearchView()
        .environmentObject(MusicManager())
    
}

