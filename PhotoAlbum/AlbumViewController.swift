//
//  AlbumViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let store = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchAlbums()  
        
    }
    
    func fetchAlbums() {
        store.getAlbums {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePhotosforAlbum" {
            let destVC = segue.destination as! PhotoViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            
            // TODO: - Fix indexPAth.item
            destVC.albumPhotos = store.albums[(indexPath?.item)!].photos
        }
    }
    
    @IBAction func unwindSegueToSelf(segue: UIStoryboardSegue) {
        
        
    }
    
    
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.albums.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! TableViewCell
        let album = store.albums[indexPath.row]
        cell.delegate = self
        cell.albumLabel.text = "Album \(album.albumID)"
        cell.photosLabel.text = "\(album.photos.count) Photos"
    //    cell.photoImageView.image =
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentCell = cell as! TableViewCell

        let photo = store.albums[indexPath.item].photos[0]
        currentCell.photo = photo
    }
    
}

// MARK: - Collection View Cell Delegate
extension AlbumViewController: AlbumCellDelegate {
    
    func albumCell(_ albumCell: TableViewCell, canDisplayPhoto photo: Photo) -> Bool {
        var visiblePhotos: Set<Int> = []

        if let visibleIndexPaths = tableView.indexPathsForVisibleRows {
        
        
            for indexPath in visibleIndexPaths {
                let photoAtIndexPath = store.albums[indexPath.item].photos[0]
                visiblePhotos.insert(photoAtIndexPath.id)

        }
        
        }
        return visiblePhotos.contains(photo.id)

}
}
