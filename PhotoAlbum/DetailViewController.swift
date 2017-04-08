//
//  DetailViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var photoID: Int?
    var photo: Photo?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    
    }
    
    func configureViews() {
        
        guard let selectedPhoto = photo else {
            return
        }
        
        imageView.image = loadImage(from: selectedPhoto.urlString)
        
        descriptionLabel.sizeToFit()
        descriptionLabel.text = photo?.title
        
        
    }
    
    // NOTE: - Downloading may be okay since it will only happen once
    
    func loadImage(from imageURL: String) -> UIImage? {
        if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
            if data != nil {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    
    // NOTE: - Not in use?
    @IBAction func cancelButtonTapped(_ sender: Any) {

        self.dismiss(animated: true, completion: nil);

        
    }
    
    
    
    
}
