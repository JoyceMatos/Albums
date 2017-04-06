//
//  MasterViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/6/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!
    @IBOutlet weak var photoContainerView: UIView!
    
    var albumTapped = true
    var photoTapped = false
    
    @IBAction func albumTapped(_ sender: Any) {
        
        albumTapped = true
        photoTapped = false
        
        UIView.animate(withDuration: 0.5) { 
            self.containerView.alpha = 1.0
            self.photoContainerView.alpha = 0.0
        }
        
       
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        
        albumTapped = false
        photoTapped = true
        
        UIView.animate(withDuration: 0.5) {
            self.containerView.alpha = 0.0
            self.photoContainerView.alpha = 1.0
        }
    }
    
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerView.alpha = 1.0
        self.photoContainerView.alpha = 0.0
    
    
    }
}

