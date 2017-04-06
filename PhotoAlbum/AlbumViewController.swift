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
    var albums = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        fetchAlbums()
        
     
        
    }
    
    func fetchAlbums() {
        store.getAlbums {
            
            for item in self.store.albumDict {
                self.albums.append(item.key)
            }
            self.albums.sort()
            print("NEW ALBUM ARRAY: \(self.albums)")
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    


}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.albumDict.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! TableViewCell
        let album = albums[indexPath.row]
        
        cell.albumLabel.text = "Album \(album)"
        cell.contentView.backgroundColor = UIColor.clear
        
            // TODO: - Constrain views
//        let whiteRoundedView = UIView(frame: CGRect(x: 20, y: 8, width: self.view.frame.size.width - 40, height: 149))
//        
//        
//        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
//        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 2.0
//        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        whiteRoundedView.layer.shadowOpacity = 0.2
//        
//        cell.contentView.addSubview(whiteRoundedView)
//        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        return cell
    }
    
    
    
    
}
