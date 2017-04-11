//
//  ImageManager.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

final class ImageManager {
    
    var images: [Photo: UIImage]!
    
    // Download thumbnail
//    func downloadImage(_ photo: Photo, handler: @escaping (Bool) -> Void) {
//       // isDownloadingImage = true
//        let session = URLSession.shared
//        let url = URL(string: photo.thumbnailURLString)!
//        let request = URLRequest(url: url)
//        session.dataTask(with: request, completionHandler: { data, response, error in
//            DispatchQueue.main.async {
//                guard let data = data,
//                    let newImage = UIImage(data: data) else {
//                        handler(false)
//                        return
//                }
//                
//                self.image = newImage
//                handler(true)
//            }
//        }).resume()
//    }
//
}
