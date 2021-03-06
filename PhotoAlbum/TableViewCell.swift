//
//  TableViewCell.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/5/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

protocol AlbumCellDelegate: class {
    
    func albumCell(_ albumCell: TableViewCell, canDisplayPhoto photo: Photo) -> Bool
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var photosLabel: UILabel!
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    weak var delegate: AlbumCellDelegate!
    weak var photo: Photo! {
        didSet {
            setupPhoto()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumLabel.text = nil
        photosLabel.text = nil
        photoImageView.image = nil
    }
    
    // MARK: - Image Method
    // NOTE: - Once networking layer (ImageManager) is created, this will call on this layer and retrieve the image from the dictionary
    private func setupPhoto() {
        if photo.image != nil {
            photoImageView.image = photo.image
            return
        }
        
        if photo.image == nil && !photo.isDownloadingImage {
            photo.downloadImage(handler: { success in
                if success {
                    guard self.delegate.albumCell(self, canDisplayPhoto: self.photo) else { return }
                    self.photoImageView.alpha = 0.0
                    self.photoImageView.image = self.photo.image
                    UIView.animate(withDuration: 1.0, animations: {
                        self.photoImageView.alpha = 1.0
                    })
                } else {
                    self.photoImageView.backgroundColor = UIColor.gray
                }
            })
        }
        
    }
    
}
