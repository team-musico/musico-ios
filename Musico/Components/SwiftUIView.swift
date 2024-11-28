//
//  SwiftUIView.swift
//  Musico
//
//  Created by dgsw07 on 11/28/24.
//

import SwiftUI
import AVKit

struct AudioPlayerView: View {
    var videoId: String
    
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack {
            Button(action: {
                toggleAudio()
            }) {
                Text(isPlaying ? "Pause" : "Play")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Capsule().fill(Color.blue))
            }
            .padding()
        }
        .onAppear {
            loadAudio()
        }
        .onDisappear {
            player?.pause()
        }
    }
    
    private func loadAudio() {
        // YouTube API를 통해 videoId로 오디오 스트리밍 URL을 가져옵니다.
        let audioUrlString = "https://www.youtube.com/watch?v=\(videoId)" // 예시 URL, 실제 API를 통해 오디오 URL을 가져와야 합니다.
        
        if let audioUrl = URL(string: audioUrlString) {
            player = AVPlayer(url: audioUrl)
        }
    }
    
    private func toggleAudio() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
    }
}

