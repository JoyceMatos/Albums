//
//  PhotoAlbumTests.swift
//  PhotoAlbumTests
//
//  Created by Joyce Matos on 4/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import XCTest
@testable import PhotoAlbum

class PhotoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoInit() {
        let json: [String: Any] = [
            "albumId" : 1,
            "id": 5,
            "title": "This is my title",
            "url": "www.blah.com",
            "thumbnailUrl": "www.blah.com"]
        
        let photo = Photo(JSON: json)
        XCTAssertEqual(photo.id, 5, "Photo id Should equal 5 through its init function.")
    }
    
    
    
}
