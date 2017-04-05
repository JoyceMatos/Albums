//
//  UnwindDetailViewSegue.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/4/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class UnwindDetailViewSegue: UIStoryboardUnwindSegueSource {
    
    
    class UIStoryboardUnwindSegueFromRight: UIStoryboardSegue {
        
        override func perform() {
            let src = self.source as UIViewController
            let dst = self.destination as UIViewController
            
            src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
            src.view.transform = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
                
                src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
            }, completion: { finished in
                
                src.dismiss(animated: false, completion: nil)
            })
        }
    }

}
