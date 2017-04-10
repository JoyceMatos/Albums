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


// NOTE: - Remove maybe?
extension Album: Equatable {

    static func == (lhs: Album, rhs: Album) -> Bool {
        return (lhs.albumID == rhs.albumID)
    }
    
}
