//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let store = AlbumDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        

      self.store.getPhotos { (photos) in
       
        print("Hey these are the photos I am printing: \(self.store.photos)")
        
        }
    }


}

