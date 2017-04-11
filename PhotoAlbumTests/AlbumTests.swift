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
        
        let json1: [String: Any] = [
            "albumId" : 57,
            "id": 5,
            "title": "This is my title",
            "url": "http://placehold.it/150/121fa4",
            "thumbnailUrl": "http://placehold.it/150/121fa4"]
        let json2: [String: Any] = [
            "albumId" : 57,
            "id": 9,
            "title": "This is my title",
            "url": "http://placehold.it/150/121fa4",
            "thumbnailUrl": "http://placehold.it/150/121fa4"]
        let json3: [String: Any] = [
            "albumId" : 57,
            "id": 43,
            "title": "This is my title",
            "url": "http://placehold.it/150/121fa4",
            "thumbnailUrl": "http://placehold.it/150/121fa4"]
        
        let photos = [Photo(JSON: json1), Photo(JSON: json2), Photo(JSON: json3)]
        let album = Album(albumID: 57, photos: photos)
        XCTAssertEqual(album.albumID, 57, "Album should be equal to 57")
    }
    
}
