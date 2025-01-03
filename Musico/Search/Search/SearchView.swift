//
//  SearchView.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//
//에픽하이,애쉬아일, 서이브, 아비치, 순순히, 황인욱, 엠씨몽

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State private var selectedSong: Song? = nil
    @State private var searchClick = false
    @State private var showNoResultsMessage = false

    var body: some View {
        VStack {
            Header()
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
                                        .onChange(of: viewModel.search) { search in
                                            searchClick = false
                                            showNoResultsMessage = false
                                        }

                                    Button {
                                        if !viewModel.search.isEmpty {
                                            viewModel.fetchSongs(search: viewModel.search)
                                            searchClick = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                if viewModel.searchSongs.isEmpty {
                                                    showNoResultsMessage = true
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
                            Spacer()
                        }
                    } else if searchClick {
                        if showNoResultsMessage && viewModel.searchSongs.isEmpty {
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
                                    HStack(alignment: .top) {
                                        AsyncImage(url: URL(string: song.albumArt)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        } placeholder: {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray)
                                                .frame(width: 100, height: 100)
                                        }
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(song.title)
                                                .font(.system(size: 20, weight: .bold))
                                            Spacer().frame(height: 12)
                                            Text(song.artists.map { $0.artistName }.joined(separator: ", "))
                                                .foregroundColor(.secondary)
                                                .font(.system(size: 14))
                                        }
                                        .padding(.top, 15)
                                        .padding(.leading, 7)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
        }
    }
}






#Preview {
    SearchView()
}
