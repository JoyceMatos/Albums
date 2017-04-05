//
//  PhotoAlbumTests.swift
//  PhotoAlbumTests
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import XCTest
@testable import PhotoAlbum

class PhotoAlbumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoInit() {
        
        let photo = Photo(albumID: 3, id: 3, title: "Michael", url: "www.blah.com", thumbnailURL: "nope")
        XCTAssertEqual(photo.albumID, 3, "Album ID Should equal 3 through its init function.")
        
    }
   
}
