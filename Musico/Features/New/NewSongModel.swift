 

import Foundation

struct NewSong: Identifiable,Codable,Equatable {
    var id: Int { trackId }
    var title: String
    var albumArt: String
    var artists: [NewSongArtists]
    var trackId: Int
}

struct NewSongArtists: Codable, Equatable {
    var artistId : Int
    var artistName : String
    var imageUrl : String?
}
 
