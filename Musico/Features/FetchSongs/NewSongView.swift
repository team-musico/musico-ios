//
//  NewSongView.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import SwiftUI

struct NewSongView: View {
    @StateObject var viewModel = ChartViewModel()
    @State private var selectedSong: Song? = nil
    @State private var sideBarOn = false
    @State private var expandSheet = false
    @Namespace private var animation

    var body: some View {
        VStack {
            Header(sideBarOn: $sideBarOn)
            ScrollView {
                Text("최신 노래")
                    .font(.system(size: 21).weight(.bold))
                    .padding(.trailing, 180)
                
                
                if viewModel.islogging {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.newSongs) { song in
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
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                selectedSong = song
                            }
                            .background(
                                NavigationLink(destination: SongDetailView(song: song)) {
                                    EmptyView()
                                }
                                    .hidden()
                            )
                        }
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.2)
                        .frame(width: 500, height: 500)
                }
            }
            .foregroundColor(.black)
            
            if selectedSong != nil {
                ZStack {
                    if expandSheet {
                        Rectangle()
                            .fill(.clear)
                    } else {
                        Rectangle()
                            .fill(.ultraThickMaterial)
                            .ignoresSafeArea()
                            .frame(height: 70)
                            .overlay {
                                MusicInfo(expandSheet: $expandSheet, animation: animation, selectedSong: selectedSong)
                            }
                            .matchedGeometryEffect(id: "BGVIEW", in: animation)
                    }
                }
            }
        }
        .overlay {
            if expandSheet {
                ExpandBottomeSheet(expandSheet: $expandSheet, animation: animation, song: selectedSong)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .onAppear {
            viewModel.fetchNewSongs()
        }
    }
}

#Preview {
    NewSongView()
}
