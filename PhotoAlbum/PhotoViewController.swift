//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let store = DataStore.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    fileprivate let itemsPerRow: CGFloat = 3 // Has to specify CGFloat or it will be a double
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
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
                
             //   self.store.getAlbums()

                self.collectionView.reloadData()
                
                

            }
        }
    }
    
    // TODO : - This can be part of a protocol
    func loadImage(from imageURL: String) -> UIImage? {
        if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
            if data != nil {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    
    
    @IBAction func unwindSegueToSelf(segue: UIStoryboardSegue) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destVC = segue.destination as! DetailViewController
            let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell)
            
          // TODO: - Fix indexPAth.item
            destVC.photo = store.photos[(indexPath?.item)!]
        }
    }


}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionViewCell
        if cell.delegate == nil {
            cell.delegate = self
            cell.backgroundColor = UIColor.clear

        }
        
     //   cell.image.image = loadImage(from: photo.thumbnailURL)
        
        
        // Smooth scrolling but images change
//        cell.image.imageFromServerURL(urlString: photo.thumbnailURL)
        
//        cell.backgroundColor = UIColor.blue
        
        
//        cell.layer.shouldRasterize = true
//        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow) // can add 1 to itemsPerRow to add more space
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCell = cell as! CollectionViewCell
        let photo = store.photos[indexPath.item]
        currentCell.photo = photo
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
}



// MARK: - Collection View Cell Delegate 
extension PhotoViewController: PhotoCellDelegate {
    
    func photoCell(_ photoCell: CollectionViewCell, canDisplayPhoto photo: Photo) -> Bool {
            let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        
        var visiblePhotos: Set<Int> = []
        
        for indexPath in visibleIndexPaths {
            let photoAtIndexPath = store.photos[indexPath.item]
            visiblePhotos.insert(photoAtIndexPath.id)
        }
        
        return visiblePhotos.contains(photo.id)
    }
    
}

// Smooth scrolling but images change
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: URL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}



