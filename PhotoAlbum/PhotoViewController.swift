//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

protocol DisplayPhotos: class {
    
    func displayCount(_ albumPhotos: [Photo], allPhotos: [Photo]) -> Int
    func displayPhoto(_ albumPhotos: [Photo], allPhotos: [Photo]) -> [Photo]
    
}

class PhotoViewController: UIViewController {
    
    let store = DataStore.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    let refreshControl = UIRefreshControl()
    let itemsPerRow: CGFloat = 3 // Specify CGFloat or it will be a double
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 10.0, right: 10.0) 
    var albumID: Int?
    var albumPhotos = [Photo]()
    var allPhotos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        determinePhotoSource()
        configureViews()
        refresh()
        
    }
    
    
    // MARK - View Method
    func configureViews() {
        if albumPhotos.isEmpty {
            backButton.isHidden = true
            repositionCollectionView()
        } else {
            backButton.isHidden = false
        }
    }
    
    // NOTE: - This function repositions the collection view when photos of the same album are being viewed
    func repositionCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Fetch Data Source Methods
    func retrievePhotos() {
        self.store.getPhotos { (photos) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func determinePhotoSource() {
        albumPhotos.isEmpty ? retrievePhotos() : store.getAlbums {
            print(self.store.photos)
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Refresh Methods
    func refresh() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadCollectionView), for: .valueChanged)
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Segue Methods
    @IBAction func unwindSegueToSelf(segue: UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showDetail {
            let destVC = segue.destination as! DetailViewController
            guard let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell) else {
                return
            }
            destVC.photo = displayPhoto(albumPhotos, allPhotos: store.photos)[indexPath.item]
        }
    }
    
    
}

// MARK: - CollectionView Methods
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



