//
//  MyPlaylistView.swift
//  Musico
//
//  Created by dgsw07 on 11/25/24.
//

import SwiftUI

struct MyPlaylistView: View {
    @StateObject private var viewModel = PlaylistViewModel()
    @State private var playlistName = ""
    
    var body: some View {
        VStack {
            TextField("플레이리스트 이름을 입력하세요", text: $playlistName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("플레이리스트 생성") {
                viewModel.createPlaylist(playlistName: playlistName) { success in
                    if success {
                        print("플레이리스트 생성 성공!")
                    } else {
                        print("플레이리스트 생성 실패")
                    }
                }
            }
            .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text("오류: \(errorMessage)")
                    .foregroundColor(.red)
            }
            
            if viewModel.isSuccess {
                Text("플레이리스트 생성 성공!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}


#Preview {
    MyPlaylistView()
}