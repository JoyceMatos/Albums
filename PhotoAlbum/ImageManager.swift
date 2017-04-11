//
//  ImageManager.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit


// NOTE: - This class is not completed and is not been called anywhere. The goal of this class is to seperate the functionality between the networking calls for downloading images and the data models. As the project stands, the data models are downloading the images, however, having a seperate class that handles this functionality would allow the data models to do what they do best, be models for holding data.

final class ImageManager {
    
    let shared = ImageManager()
    let store = DataStore.shared
    var thumbnailImages: [Photo: UIImage]!
    var detailImages: [Photo: UIImage]!
    
    func downloadImage(_ photo: Photo, photoType: PhotoType, handler: @escaping (Bool) -> Void) {
        let session = URLSession.shared
        var urlString = String()
        
        switch photoType {
        case .thumbnail:
            urlString = photo.thumbnailURLString
        case .detail:
            urlString = photo.urlString
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                    let newImage = UIImage(data: data) else {
                        handler(false)
                        return
                }
                
                switch photoType {
                case .thumbnail:
                    self.thumbnailImages[photo] = newImage
                    handler(true)
                case .detail:
                    self.detailImages[photo] = newImage
                    handler(true)                }
                
            }
        }).resume()
        
        for photo in thumbnailImages {
            
            print("This photo is in album#: \(photo.key.albumID), photo: \(photo.key.id)")
        }
        
        
    }
    
}
