//
//  AlbumAPIClient.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

final class APIClient {
    
    static func retrieveJSON(completion: @escaping ([[String: Any]]) -> Void) {
        
        let urlString = "http://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        
       // let jsonData = try? JSONSerialization.data(withJSONObject: [[String: Any]]())

        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      //  request.httpBody = jsona
        
        
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else  {
                return
            }
            
         //   let encodedData = data.base64EncodedData()
            
            print("This is the response: \(response)")
            
            do {
                
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                DispatchQueue.main.async {
                    //  DispatchQueue.global(qos: .userInitiated).async {
                    completion(responseJSON)
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        
        }


      //  let task = session.dataTask(with: url) { (data, response, error) in
//                guard let data = data else  {
//                    return
//                }
//            
//            print("This is the data: \(data)")
//            print("this is the response: \(response)")
//            
////            var dataString = String(data: data, encoding: String.Encoding.utf8)!
////            dataString = dataString.replacingOccurrences(of: "\\", with: "'")
////            let cleanData: Data = dataString.data(using: String.Encoding.utf8)!
////            
//            
//            print("This is the clean data \(cleanData)")
//
//                do {
//                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
//                    DispatchQueue.main.async {
//                  //  DispatchQueue.global(qos: .userInitiated).async {
//                        completion(responseJSON)
//                    }
//
//                } catch {
//                    print(error.localizedDescription)
//                }
//            
//            
        
        
      //  task.resume()
            sessionTask.resume()

        
    }


    
    
    
}
