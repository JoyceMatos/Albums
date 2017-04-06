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
        print("Removing all")
        
        APIClient.retrieveJSON { (album) in
                print("----- Right before my loop ----")
                for photo in album {
                    
                    let albumID = photo["albumId"] as! Int
                    let id = photo["id"] as! Int
                    let title = photo["title"] as! String
                    let url = photo["url"] as! String
                    let thumbnailURL = photo["thumbnailUrl"] as! String
                    
                    let photo = Photo(albumID: albumID, id: id, title: title, urlString: url, thumbnailURLString: thumbnailURL)
                    print("This is the photo: \(photo)")
                    self.photos.append(photo)
                }
            
            completion(self.photos)
        }
    }
    
    func getAlbums(completion: @escaping () -> Void)  {
        albums.removeAll()
        
        // NOTE: - Refine w. higher order functions
        getPhotos { (photosArray) in
            
            for photo in self.photos {
                
                // print("Hey this is the photo:\(photo)")
                
                let key = photo.albumID
                let value = [photo]
                
                if self.albumDict.keys.contains(key) {
                    self.albumDict[key]?.append(photo)
                } else {
                    self.albumDict[key] = value
                }
            }
            completion()
            
            
        }
        
        
        
//        APIClient.retrieveJSON { (JSON) in
//            
//            
//            for object in JSON {
//                
//                let albumID = object["albumId"] as! Int
//                let id = object["id"] as! Int
//                let title = object["title"] as! String
//                let url = object["url"] as! String
//                let thumbnailURL = object["thumbnailUrl"] as! String
//                
//                let photo = Photo(albumID: albumID, id: id, title: title, urlString: url, thumbnailURLString: thumbnailURL)
//                
//                var album = Album(albumID: albumID, photos: [photo])
        
                // If albums array contains an album with this id, then append photo
                
//                if self.albums.contains(where: {$0.albumID == photo.albumID}) {
//                        $0.photos.append(photo)
//                } else {
//                    //item does NOT exist
//                }
                
//                let specificAlbum = self.albums.filter({ $0.albumID == photo.albumID }).first
//                

//                guard let index = self.albums.index(where: {$0.albumID == photo.albumID}) else  {
//                    return
//                }
//
//                var mainAlbum = self.albums[index]
//                mainAlbum.photos.append(photo)
                


        
        
    }

    
    
}

