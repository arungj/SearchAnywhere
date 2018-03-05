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
    
    // Test ARGSearchHandler by passing a empty search text.
    func testEmptySearchText() {
        let searchText = ""
        let isSearching = searchHandler.search(text: searchText) { _, _ in }
        // Expected result
        XCTAssertFalse(isSearching)
    }
    
    func testValidSearchText() {
        let searchText = "hello"
        let isSearching = searchHandler.search(text: searchText) { _, _ in }
        XCTAssertTrue(isSearching)
    }
}
