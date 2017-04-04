//
//  AlbumDataStore.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

class AlbumDataStore {
    
    static let shared = AlbumDataStore()
    var photos = [Photo]()
    
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        photos.removeAll()
        print("Removing all")
        
        AlbumAPIClient.retrieveJSON { (album) in
                print("----- Right before my loop ----")
                for photo in album {
                    
                    let albumID = photo["albumId"] as! Int
                    let id = photo["id"] as! Int
                    let title = photo["title"] as! String
                    let url = photo["url"] as! String
                    let thumbnailURL = photo["thumbnailUrl"] as! String
                    
                    let photo = Photo(albumID: albumID, id: id, title: title, url: url, thumbnailURL: thumbnailURL)
                    print("This is the photo: \(photo)")
                    self.photos.append(photo)
                }
            
            print("This is where my photos should be ***** \(self.photos)")
            completion(self.photos)
        }
    }

    
    
}
