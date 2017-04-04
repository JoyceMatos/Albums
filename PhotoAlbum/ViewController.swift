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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        retrievePhotos()
      
    }
    
    func retrievePhotos() {
        self.store.getPhotos { (photos) in
            DispatchQueue.main.async {
                print("reloading data")
                self.collectionView.reloadData()
            }
        }
    }
    
    func downloadImage(from url: String) {
        let url = URL(string: url)
        
        
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionViewCell
        
        let photo = store.photos[indexPath.item]
        
        cell.label.text = "\(photo.id)"
        cell.backgroundColor = UIColor.blue
        
        
        return cell
    }
    
    
    
    
}

