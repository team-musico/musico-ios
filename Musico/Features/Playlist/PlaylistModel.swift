//
//  PlaylistModel.swift
//  Musico
//
//  Created by dgsw07 on 11/25/24.
//

import Foundation


struct PlaylistModel:Identifiable, Codable {
    var id: Int { trackId }
    let title: String
    let artist: [Artist]
    let videoId: [String]
    let trackId: Int
    let coverUrl: String
}

struct PlaylistArtist: Codable {
    let artistName: String
    let artistId: Int
    let isGroup: Bool
    let imageUrl: String
}
