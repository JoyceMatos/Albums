//
//  AlbumAPIClient.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

final class AlbumAPIClient {
    
    static func retrieveJSON(completion: @escaping ([[String: Any]]) -> Void) {
        
        let urlString = "http://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
                    
                        print("JSON: \(responseJSON)")
                        completion(responseJSON)

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }


    
    
    
}
