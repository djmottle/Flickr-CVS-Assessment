//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by David Mottle on 1/28/25.
//

import XCTest
@testable import Flickr

final class FlickrTests: XCTestCase {
    var image: Image?
    var viewModel: ImageListModel? = nil
    var mockService: MockFlickrFetcher!

    override func setUp() {
        super.setUp()
        mockService = MockFlickrFetcher()
        image = Image(
            title: "308 at Kidd",
            link: "https://www.flickr.com",
            media: ["m":"https://live.staticflickr.com/65535/54292384823_52a5c0d6cb_m.jpg"],
            description: """
                <p><a href="https://www.flickr.com/people/107626626@N06/">ildikoannable</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/107626626@N06/54249235448/" title="Porcupine"><img src="https://live.staticflickr.com/65535/54249235448_7a10b2308b_m.jpg" width="240" height="163" alt="Porcupine" /></a></p> <p>Porcupine spotted on the ground snacking on twigs.</p>
                """,
            published: "2025-01-28T12:39:14Z",
            author: "nobody@flickr.com (\"GLC 392\")",
            tags: "onr ontario northland railroad railway ont kidd mining on timmins 207 208 train 2105 2104 snow drone dji hoyle porcupine river bridge ramore sub subdivison")
        }

    override func tearDown() {
        image = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFormattedAuthor() {
        XCTAssertEqual(image?.formattedAuthor, "GLC 392")
    }
    
    func testFormattedDate() {
        XCTAssertEqual(image?.formattedDate, "Jan 28, 2025")
    }
    
    func testFormattedDescription() {
        XCTAssertEqual(image?.formattedDescription, "Porcupine spotted on the ground snacking on twigs.")
    }
    
    func testSuccesfulResponse() async {
        let mockJSON = """
        {
        "items": [
           {
                "title": "North American porcupine (Erethizon dorsatum)",
                "link": "https://www.flickr.com/photos/evanjenkins/54293080077/",
                "media": {"m":"https://live.staticflickr.com/65535/54293080077_a834ecbf0e_m.jpg"},
                "description": " <p><a href="https://www.flickr.com/people/evanjenkins/">rangerbatt</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/evanjenkins/54293080077/" title="North American porcupine (Erethizon dorsatum)"><img src="https://live.staticflickr.com/65535/54293080077_a834ecbf0e_m.jpg" width="240" height="160" alt="North American porcupine (Erethizon dorsatum)" /></a></p> ",
                "published": "2025-01-29T01:38:51Z",
                "author": "nobody@flickr.com (\\\"rangerbatt\\\")",
                "tags": "rodent sigma150600mmsports d7500 winter utahwildlife wildutah wasatchmountains porcupine porcupineintree erethizondorsatum northamericanporcupine tree animal"
           }
        ]
    }
    """
        mockService.mockData = mockJSON.data(using: .utf8)
        mockService.mockResponseCode = 200
        
        do {
            try await mockService.fetchData(tags: "porcupine")
            XCTAssertEqual(mockService.mockImageData.items?.count, 1)
            XCTAssertEqual(mockService.mockImageData.items?.first?.title, "North American porcupine (Erethizon dorsatum)")
        } catch {
            print("Error: Decoding failed")
        }
        
    }
}
