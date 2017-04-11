//
//  DetailViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

//NOTE: - I was hoping to include gesture recognizers to make the detailed photos more interactive and allow the users to swipe to dismiss the view.

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var photoID: Int?
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    // MARK: - View Method
    func configureViews() {
        guard let selectedPhoto = photo else {
            return
        }
        
        //Load image
        imageView.image = loadImage(from: selectedPhoto.urlString)
        
        //Set up description label
        descriptionLabel.sizeToFit()
        descriptionLabel.text = photo?.title
    }
    
    
    // NOTE: - This operation should be executed in it's own network layer (ImageManager)
    func loadImage(from imageURL: String) -> UIImage? {
        if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
        }
        return nil
    }
    
    // MARK: - Action Method
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}
