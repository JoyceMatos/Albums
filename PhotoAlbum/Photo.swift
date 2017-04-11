//
//  Photo.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

final class Photo {
    
    let albumID: Int
    let id: Int
    let title: String
    let urlString: String
    let thumbnailURLString: String
    var image: UIImage?
    var isDownloadingImage = false
    var hashValue: Int {
        return id.hashValue
    }
    
    init(JSON: JSON) {
        self.albumID = JSON["albumId"] as! Int
        self.id = JSON["id"] as! Int
        self.title = JSON["title"] as! String
        self.urlString = JSON["url"] as! String
        self.thumbnailURLString = JSON["thumbnailUrl"] as! String
    }
    
    
    // NOTE: - Model should not handle this information. Extract functionality and perform any downloads in a networking layer
    func downloadImage(handler: @escaping (Bool) -> Void) {
        isDownloadingImage = true
        let session = URLSession.shared
        let url = URL(string: thumbnailURLString)!
        let request = URLRequest(url: url)
        session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                    let newImage = UIImage(data: data) else {
                        handler(false)
                        return
                }
                
                self.image = newImage
                handler(true)
            }
        }).resume()
    }
    
    
}

// NOTE: - This extension was created with the intension of making the Photos hashable so that I can create a dictionary of [Photo: Image] in the networking layer. Essentially, this dictionary would be used to populate the data models with the images without having to download the images themselves.
extension Photo: Hashable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.albumID == rhs.albumID
    }
    
}

