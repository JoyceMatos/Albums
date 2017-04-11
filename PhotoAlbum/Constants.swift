//
//  Constants.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/9/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct SegueIdentifiers {
    
    static let showDetail = "showDetail"
    static let showPhotos = "showPhotos"
    
}

struct CellIdentifiers {
    
    static let photoCell = "photoCell"
    static let albumCell = "albumCell"
    
}

struct APIDetails {
    
    static let baseURLString = "http://jsonplaceholder.typicode.com/photos"
    
}

enum PhotoType {
    
    case thumbnail
    case detail
    
}
