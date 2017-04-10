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
    
    init(albumID: Int, id: Int, title: String, urlString: String, thumbnailURLString: String) {
        self.albumID = albumID
        self.id = id
        self.title = title
        self.urlString = urlString
        self.thumbnailURLString = thumbnailURLString
    }
    
    init(JSON: JSON) {
        self.albumID = JSON["albumId"] as! Int
        self.id = JSON["id"] as! Int
        self.title = JSON["title"] as! String
        self.urlString = JSON["url"] as! String
        self.thumbnailURLString = JSON["thumbnailUrl"] as! String
    }
    
    
    // TODO: - Perform something similar in Image Manager
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
