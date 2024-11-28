//
//  ChartModel.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import Foundation


struct Song: Identifiable, Codable, Equatable {
    var id: Int { trackId }
    var title: String
    var artists: [Artist]
    var trackId: Int
    var albumArt: String?
    var videoId: [String]?  
}


struct Artist : Codable,Equatable {
    var artistName: String
    var artistId: Int
    var imageUrl: String?
}


//{
//    "title": "Whiplash",
//    "albumArt": "https://musicmeta-phinf.pstatic.net/album/032/223/32223740.jpg?type=r480Fll&v=20241021143055",
//    "artists": [
//      {
//        "artistId": 3980296,
//        "artistName": "aespa",
//        "isGroup": true,
//        "imageUrl": "https://musicmeta-phinf.pstatic.net/artist/003/980/3980296.jpg?type=r300&v=20241016100718"
//      }
//    ],
//    "trackId": 87532802
//  },
