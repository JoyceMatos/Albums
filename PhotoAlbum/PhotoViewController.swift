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
    @IBOutlet weak var backButton: UIButton!
    let refreshControl = UIRefreshControl()
    let itemsPerRow: CGFloat = 3 // Specify CGFloat or it will be a double
    let sectionInsets = UIEdgeInsets(top: 30.0, left: 10.0, bottom: 30.0, right: 10.0) // 50, 20
    var albumID: Int?
    var albumPhotos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       determinePhotoSource()
        configureViews()
        refresh()
        
    }
    
    func configureViews() {
        
        if albumPhotos.isEmpty {
            backButton.isHidden = true
            
            // TODO: - Adjust collectionview constraint
        } else {
            backButton.isHidden = false
        }
    }
    
    func retrievePhotos() {
        self.store.getPhotos { (photos) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func determinePhotoSource() {
        if albumPhotos.isEmpty {
            retrievePhotos()
        } else {
            store.getAlbums {
            }
        }
    }
    
    func refresh() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadCollectionView), for: .valueChanged)
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
    @IBAction func unwindSegueToSelf(segue: UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showDetail {
            let destVC = segue.destination as! DetailViewController
            let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell)
            
            // TODO: - Fix indexPAth.item
                destVC.photo = displayPhoto(albumPhotos, allPhotos: store.photos)[(indexPath?.item)!]
        }
    }
    
    
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayCount(albumPhotos, allPhotos: store.photos)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.photoCell, for: indexPath) as! CollectionViewCell
        if cell.delegate == nil {
            cell.delegate = self
            cell.backgroundColor = UIColor.clear
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let currentCell = cell as! CollectionViewCell
        let photo = displayPhoto(albumPhotos, allPhotos: store.photos)[indexPath.item]
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
                let photoAtIndexPath = displayPhoto(albumPhotos, allPhotos: store.photos)[indexPath.item]
                visiblePhotos.insert(photoAtIndexPath.id)
            }
        
        return visiblePhotos.contains(photo.id)
    }
    
}

// MARK: - Display Photos Methods
extension PhotoViewController: DisplayPhotos {
    
    func displayCount(_ albumPhotos: [Photo], allPhotos: [Photo]) -> Int {
        if albumPhotos.isEmpty {
            return store.photos.count
        } else {
            return albumPhotos.count
        }
    }
    
    func displayPhoto(_ albumPhotos: [Photo], allPhotos: [Photo]) -> [Photo] {
        if albumPhotos.isEmpty  {
            return store.photos
        } else {
            return albumPhotos
        }
    }

}



