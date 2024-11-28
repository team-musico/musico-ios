//
//  MusicInfo.swift
//  Musico
//
//  Created by dgsw07 on 11/28/24.
//

import SwiftUI

struct MusicInfo: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    var selectedSong: Song?
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if let song = selectedSong, !expandSheet {
                    GeometryReader { geo in
                        AsyncImage(url: URL(string: song.albumArt ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray)
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                }
            }
            .frame(width: 45, height: 45)
            
            if let song = selectedSong {
                VStack {
                    Text(song.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .frame(width: 180, alignment: .leading)
                        .padding(.leading, 10)
                    Text(song.artists.map { $0.artistName }.joined(separator: ", "))
                        .font(.system(size:13))
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .frame(width: 180, alignment: .leading)
                        .padding(.leading, 10)
                }
            }
            
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            Button {
                //
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, 25)
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
        .foregroundColor(.primary)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}
