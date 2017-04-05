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
        
        imageView.image = loadImage(from: selectedPhoto.url)
        
        descriptionLabel.sizeToFit()
        descriptionLabel.text = photo?.title
        
        
    }
    
    func loadImage(from imageURL: String) -> UIImage? {
        if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
            if data != nil {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        

//        UIView.animate(withDuration: 0.30, delay: 0.0, options: .curveEaseIn, animations: {
//            
//        }, completion: nil)
//        
//        perform(<#T##aSelector: Selector##Selector#>, with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)
      //  performSegue(withIdentifier: "photoView", sender: self)

        
        
    }
    
    
    
    
}
