//
//  AlbumTests.swift
//  PhotoAlbum
//
//  Created by Joyce Matos on 4/6/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import XCTest
@testable import PhotoAlbum


class AlbumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumInit() {
        let photos = [
        Photo(albumID: 57, id: 5, title: "photo1", urlString: "www.blah.com", thumbnailURLString: "www.blah.com"),
        Photo(albumID: 57, id: 7, title: "photo2", urlString: "www.blah.com", thumbnailURLString: "www.blah.com"),
        Photo(albumID: 57, id: 4, title: "photo3", urlString: "www.blah.com", thumbnailURLString: "www.blah.com")
        ]
        
        let album = Album(albumID: 57, photos: photos)
        XCTAssertEqual(album.albumID, 57, "Album should be equal to 57")
    }
    
}
