//
//  Album.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct Album {
    
    let albumID: Int
    var photos: [Photo]
    
}


// NOTE: - This extension is not used, but it was created to make Album equatable so that I can compare ablums when I refactor the getAlbums() in the DataStore
extension Album: Equatable {

    static func == (lhs: Album, rhs: Album) -> Bool {
        return (lhs.albumID == rhs.albumID)
    }
    
}
