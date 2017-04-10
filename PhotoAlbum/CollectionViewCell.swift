//
//  CollectionViewCell.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    
    func photoCell(_ photoCell: CollectionViewCell, canDisplayPhoto photo: Photo) -> Bool
    
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    weak var photo: Photo! {
        didSet {
            setupPhoto()
        }
    }
    
    weak var delegate: PhotoCellDelegate!
    
    // MARK: - Image Method
    private func setupPhoto() {
        if photo.image != nil {
            image.image = photo.image
            return
        }
        
        
        // TODO: - Once Image Manager is in place, check for photo id and album id
        if photo.image == nil && !photo.isDownloadingImage {
            photo.downloadImage(handler: { success in
                if success {
                    guard self.delegate.photoCell(self, canDisplayPhoto: self.photo) else { return }
                    self.image.alpha = 0.0
                    self.image.image = self.photo.image
                    UIView.animate(withDuration: 1.0, animations: {
                        self.image.alpha = 1.0
                    })
                } else {
                    // TODO: Give it default image maybe?
                }
            })
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
}

