//
//  SearchModel.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import Foundation

struct SearchSong: Identifiable, Codable {
    var id: Int { trackId }
    var albumArt: String
    var title: String
    var artists: [Artists]
    var trackId: Int
    
    enum CodingKeys: String, CodingKey {
        case albumArt, title, artists, trackId
    }
}

struct Artists: Codable {
    var artistId: Int
    var artistName: String
    var imageUrl: String
    var debutDate: String
    var genreNames: String
    var likeCount: Int
    var isGroup: Bool
    
    enum CodingKeys: String, CodingKey {
        case artistId, artistName, imageUrl, debutDate, genreNames, likeCount, isGroup
    }
}
//{
//    "title": "남자를 몰라",
//    "albumArt": "https://musicmeta-phinf.pstatic.net/album/000/039/39164.jpg?type=r480Fll&v=20231103160507",
//    "artists": [
//      {
//        "artistId": 8931,
//        "artistName": "버즈",
//        "imageUrl": "https://musicmeta-phinf.pstatic.net/artist/000/008/8931.jpg?type=r300&v=20240513155009",
//        "debutDate": "2003-10-10",
//        "genreNames": "발라드, 락",
//        "likeCount": 0,
//        "isGroup": true
//      }
//    ],
//    "trackId": 575348
//  },
