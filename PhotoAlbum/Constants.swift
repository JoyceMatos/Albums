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

//enum ErrorMessage: String, Error {
//    case noUrl = "Error - No URL found"
//    case retrievingError = "Error retrieving data from the server"
//    case uploadingError = "Error uploading data to the server"
//    case updatingError = "Error updating data to the server"
//    case deletingError = "Error deleting data from the server"
//}
