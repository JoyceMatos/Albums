//
//  MasterViewController.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/6/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var albumContainerView: UIView!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var photoView: UIView!
    var actingVC: UIViewController!
    var albumTapped = true
    var photoTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    // MARK: - View Method
    func configureViews() {
        self.albumContainerView.alpha = 1.0
        self.photoContainerView.alpha = 0.0
        self.albumView.isHidden = false
        self.photoView.isHidden = true
    }
    
    // MARK: - Action Methods
    @IBAction func albumTapped(_ sender: Any) {
        albumTapped = true
        photoTapped = false
        
        animateAlbumView()
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        albumTapped = false
        photoTapped = true
        
        animatePhotoView()
    }
    
    // MARK: - Animate Container Views
    func animateAlbumView() {
        UIView.animate(withDuration: 0.5) {
            self.albumContainerView.alpha = 1.0
            self.photoContainerView.alpha = 0.0
            self.albumView.isHidden = false
            self.photoView.isHidden = true
        }
    }
    
    func animatePhotoView() {
        UIView.animate(withDuration: 0.5) {
            self.albumContainerView.alpha = 0.0
            self.photoContainerView.alpha = 1.0
            self.albumView.isHidden = true
            self.photoView.isHidden = false
        }
    }
    
    // MARK: - Segue
    @IBAction func unwindToMaster(segue:UIStoryboardSegue) { }

    
}

