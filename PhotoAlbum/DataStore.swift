//
//  AlbumDataStore.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

class DataStore {
    
    static let shared = DataStore()
    var photos = [Photo]()
    var albums = [Album]()
    var albumDict = [Int: [Photo]]()
    
    // NOTE: - This function should be removed because it is storing two arrays of the same photos in memory. This is essentially doing what getAlbums() is doing.
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        photos.removeAll()
        APIClient.retrieveJSON { (album) in
            guard let albumArray = album else {
                return
            }
            
            for photo in albumArray {
                let photo = Photo(JSON: photo)
                self.photos.append(photo)
            }
            
            completion(self.photos)
        }
    }
    
    // NOTE: - This method can be refactored and perhaps use some high order function to perform these operations
    func getAlbums(completion: @escaping () -> Void)  {
        albums.removeAll()
        albumDict.removeAll()
        
        var albumPhotos = [Photo]()
        albumPhotos.removeAll()
        APIClient.retrieveJSON { (album) in
            
            guard let albumArray = album else {
                return
            }
            
            // Create an array of all photos
            for photo in albumArray {
                let photo = Photo(JSON: photo)
                albumPhotos.append(photo)
            }
            
            // Create a dictionary of [Album: [Photo]
            for photo in albumPhotos {
                let key = photo.albumID
                let value = [photo]
                
                if self.albumDict.keys.contains(key) {
                    self.albumDict[key]?.append(photo)
                } else {
                    self.albumDict[key] = value
                }
            }
            
            // Populate data models from the dictionary and store all Album objects
            for object in self.albumDict {
                let album = Album(albumID: object.key, photos: object.value)
                self.albums.append(album)
            }
            
            // Sort album objects by ID number
            self.albums.sort(by: { $0.albumID < $1.albumID })
            completion()
        }
    }
    
    
    
}

