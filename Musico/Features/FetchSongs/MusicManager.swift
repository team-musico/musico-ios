//
//  MusicManager.swift
//  Musico
//
//  Created by dgsw07 on 11/29/24.
//
import SwiftUI
import YouTubePlayerKit

class MusicManager: ObservableObject {
    @Published var currentVideoId: String = ""
    @Published var youTubePlayer: YouTubePlayer? = nil
    @Published var selectedSong: Song? = nil

    func play(videoId: String) {
        guard currentVideoId != videoId else { return }
        currentVideoId = videoId
        youTubePlayer = YouTubePlayer(
            source: .video(id: videoId),
            configuration: .init(autoPlay: true)
        )
    }

    func stop() {
        youTubePlayer = nil
        currentVideoId = ""
    }

    func updateSelectedSong(_ song: Song) {
        selectedSong = song
    }
}
