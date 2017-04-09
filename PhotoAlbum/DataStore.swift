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
    
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        photos.removeAll()
        APIClient.retrieveJSON { (album) in
            for photo in album {
                let albumID = photo["albumId"] as! Int
                let id = photo["id"] as! Int
                let title = photo["title"] as! String
                let url = photo["url"] as! String
                let thumbnailURL = photo["thumbnailUrl"] as! String
                let photo = Photo(albumID: albumID, id: id, title: title, urlString: url, thumbnailURLString: thumbnailURL)
                self.photos.append(photo)
            }
            completion(self.photos)
        }
    }
    
    func getAlbums(completion: @escaping () -> Void)  {
        albums.removeAll()
        albumDict.removeAll()
        
        var albumPhotos = [Photo]()
        APIClient.retrieveJSON { (album) in
            for photo in album {
                let albumID = photo["albumId"] as! Int
                let id = photo["id"] as! Int
                let title = photo["title"] as! String
                let url = photo["url"] as! String
                let thumbnailURL = photo["thumbnailUrl"] as! String
                let photo = Photo(albumID: albumID, id: id, title: title, urlString: url, thumbnailURLString: thumbnailURL)
                albumPhotos.append(photo)
            }
            
            for photo in albumPhotos {
                let key = photo.albumID
                let value = [photo]
                
                if self.albumDict.keys.contains(key) {
                    self.albumDict[key]?.append(photo)
                } else {
                    self.albumDict[key] = value
                }
            }
            
            for object in self.albumDict {
                let album = Album(albumID: object.key, photos: object.value)
                self.albums.append(album)
            }
            
            self.albums.sort(by: { $0.albumID < $1.albumID })
            completion()
        }
    }
    
    
    
    
}

