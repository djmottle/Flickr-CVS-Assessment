//
//  FlickrUITests.swift
//  FlickrUITests
//
//  Created by David Mottle on 1/28/25.
//

import XCTest

final class FlickrUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // Test for makign sure the search bar exists and doesn't move
    func testSearchBar() throws {
        let searchBar = app.textFields["Search..."]
        XCTAssertTrue(searchBar.exists, "Search bar exists")
        
        let searchBarFrameBeforeLoading = searchBar.frame
        
        searchBar.tap()
        searchBar.typeText("leaf")
        let searchBarFrameAfterLoading = searchBar.frame
        XCTAssertEqual(searchBarFrameBeforeLoading.origin.y, searchBarFrameAfterLoading.origin.y)
    }
    
    // Test for makign sure the image grid appears
    func testGridAppears() throws {
        let searchBar = app.textFields["Search..."]
            
        searchBar.tap()
        searchBar.typeText("leaf")
        let grid = app.images.element(boundBy: 0)
        let exists = grid.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Grid exists")
    }
    
}
