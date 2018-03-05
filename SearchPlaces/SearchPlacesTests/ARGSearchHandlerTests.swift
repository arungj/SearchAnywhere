//
//  ARGSearchHandlerTests.swift
//  SearchPlacesTests
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import XCTest
@testable import SearchPlaces

class ARGSearchHandlerTests: XCTestCase {
    var searchHandler: ARGSearchHandler!
    override func setUp() {
        super.setUp()
        searchHandler = ARGSearchHandler()
    }
    
    override func tearDown() {
        searchHandler = nil
        super.tearDown()
    }
    
    // Test case when 'ARGSearchHandler' is passed an empty search text.
    func testEmptySearchText() {
        let searchText = ""
        let isSearching = searchHandler.search(text: searchText) { _, _ in }
        XCTAssertFalse(isSearching, "Search should return false since the search text is empty.")
    }
    
    // Test case when 'ARGSearchHandler' is passed a valid search text.
    func testValidSearchText() {
        let searchText = "hello"
        let isSearching = searchHandler.search(text: searchText) { _, _ in }
        XCTAssertTrue(isSearching, "Search should return true since the search text is valid.")
    }
}
