////
////  MainView.swift
////  Musico
////
////  Created by dgsw07 on 11/21/24.
////
//
//import SwiftUI
//
//struct HomeView: View {
//    @StateObject var songViewModel = ChartViewModel()
//    
//    @State private var selectedSong: Song? = nil
//    @State private var displayedSongs: [Song] = []
//    @State private var sideBar : CGFloat = 0
//    @State private var sideBarOn  = false
//    @State private var expandSheet = false
//    @Namespace private var animation
//    
//    
//    var body: some View {
//        VStack {
//            Header(sideBarOn: $sideBarOn)
//            ScrollView {
//                LazyVStack(alignment: .leading) {
//                    
//                    HStack {
//                        Text("오늘의 추천")
//                            .font(.system(size: 20).weight(.semibold))
//                            .padding(.leading, 20)
//                            .padding(.vertical, 10)
//                        Image(systemName: "chevron.right")
//                            .font(.system(size: 16).weight(.medium))
//                    }
//                    
//                    ScrollView(.horizontal) {
//                        LazyHStack {
//                            ForEach(displayedSongs) { song in
//                                Button {
//                                    selectedSong = song
//                                    expandSheet = true 
//                                } label: {
//                                    VStack(alignment: .leading) {
//                                        AsyncImage(url: URL(string: song.albumArt ?? "")) { image in
//                                            image
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                                .frame(width: 150, height: 150)
//                                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                        } placeholder: {
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .fill(Color.gray)
//                                                .frame(width: 150, height: 150)
//                                        }
//                                        
//                                        Text(song.title)
//                                            .font(.system(size: 16, weight: .semibold))
//                                            .lineLimit(1)
//                                        
//                                        Text(song.artists.map { $0.artistName }.joined(separator: ", "))
//                                            .foregroundColor(.secondary)
//                                            .font(.system(size: 14))
//                                            .lineLimit(1)
//                                    }
//                                    .frame(width: 150)
//                                    .padding(8)
//                                }
//                            }
//                        }
//                        .padding(.horizontal, 16)
//                        .frame(height: 220)
//                    }
//                    
//                    HStack {
//                        Text("인기 순위")
//                            .font(.system(size: 20).weight(.semibold))
//                            .padding(.leading, 20)
//                            .padding(.vertical, 20)
//                        Image(systemName: "chevron.right")
//                            .font(.system(size: 16).weight(.medium))
//                    }
//                    ForEach(songViewModel.chart.prefix(5)) { songs in
//                        Button {
//                            selectedSong = songs
//                            expandSheet = true
//                        } label: {
//                            VStack {
//                                HStack {
//                                    AsyncImage(url: URL(string: songs.albumArt)) { image in
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                                            .frame(width: 80, height: 80)
//                                    } placeholder: {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .fill(Color.gray)
//                                            .frame(width: 80, height: 80)
//                                    }
//                                    .padding(.trailing, 5)
//                                    VStack(alignment: .leading) {
//                                        Text(songs.title)
//                                            .font(.system(size: 16, weight: .semibold))
//                                            .lineLimit(1)
//                                        Spacer().frame(height: 10)
//                                        Text(songs.artists.map { $0.artistName }.joined(separator: ", "))
//                                            .foregroundColor(.secondary)
//                                            .font(.system(size: 14))
//                                            .lineLimit(1)
//                                    }
//                                }
//                            }
//                            .padding(.bottom, 11)
//                        }
//                    }
//                    .padding(.leading, 17)
//                    .padding(.horizontal, 8)
//                    
//                    Spacer()
//                }
//            }
//        }
//        .overlay {
//            SideBarView(sideBarOn: $sideBarOn)
//                .offset(x: sideBarOn ? 65 : 350)
//        }
//        .foregroundColor(.black)
//        .refreshable {
//            refreshRandomSongs()
//        }
//        .onAppear {
//            songViewModel.fetchNewSongs()
//            songViewModel.fetchChart()
//        }
//        .onChange(of: songViewModel.newSongs) { newsongs in
//            refreshRandomSongs()
//        }
//        
//        if expandSheet, let selectedSong = selectedSong {
//            ZStack {
//                Rectangle()
//                    .fill(.ultraThickMaterial)
//                    .ignoresSafeArea()
//                    .frame(height: 70)
//                    .overlay {
//                        MusicInfo(expandSheet: $expandSheet, animation: animation, selectedSong: selectedSong)
//                    }
//                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
//            }
//            .transition(.move(edge: .bottom))
//        }
//    }
//    
//    private func refreshRandomSongs() {
//        if songViewModel.chart.count > 10 {
//            displayedSongs = Array(songViewModel.newSongs.shuffled().prefix(10))
//        } else {
//            displayedSongs = songViewModel.newSongs
//        }
//    }
//}
//
//#Preview {
//    HomeView()
//}
//
//
