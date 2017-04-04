//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        AlbumDataStore.getPhotos { (photos) in
            DispatchQueue.main.async {

                print("------These are the photos: \(photos)")
                
        }
        }
        
      //  print("========ohhhhhhh photos! \(AlbumDataStore.photos)")
        
        
    }



}

