//
//  AlbumAPIClient.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

final class APIClient {
    
    static func retrieveJSON(completion: @escaping ([JSON]?) -> Void) {
        guard let url = URL(string: APIDetails.baseURLString) else {
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]] else  {
                    completion(nil)
                    return
            }
        
            DispatchQueue.global(qos: .userInitiated).async {
                completion(responseJSON)
            }
        }.resume()
        
    }
    
}
