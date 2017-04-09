//
//  Helpers.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/9/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

// NOTE: - Determine whether to add all protocols here or in corresponding files

protocol DisplayPhotos: class {
    
    func displayCount(_ albumPhotos: [Photo], allPhotos: [Photo]) -> Int
    
    func displayPhoto(_ albumPhotos: [Photo], allPhotos: [Photo]) -> [Photo]

    
}
