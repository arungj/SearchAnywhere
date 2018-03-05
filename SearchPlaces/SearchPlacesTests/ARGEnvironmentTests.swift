//
//  ARGEnvironmentTests.swift
//  SearchPlacesTests
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import XCTest
@testable import SearchPlaces

class ARGEnvironmentTests: XCTestCase {
    var environmentManager: ARGEnvironment!
    override func setUp() {
        super.setUp()
        environmentManager = ARGEnvironment()
    }
    
    override func tearDown() {
        environmentManager = nil
        super.tearDown()
    }
    
    // Test the 'serviceURL' method for a search text with single word.
    func testURLForSearch() {
        let searchText = "hello"
        let url = environmentManager.serviceURL(forSearchText: searchText)
        let expectedURL = "https://maps.googleapis.com/maps/api/geocode/json?address=hello&key=AIzaSyB04cCisFvaUn-_ujcej4j4t4RjoMLt3Ss"
        XCTAssertEqual(url.absoluteString, expectedURL)
    }
    
    // Test the 'serviceURL' method for a search text with spaces in it.
    func testURLForSearchWithSpaces() {
        let searchText = "hello world"
        let url = environmentManager.serviceURL(forSearchText: searchText)
        let expectedURL = "https://maps.googleapis.com/maps/api/geocode/json?address=hello+world&key=AIzaSyB04cCisFvaUn-_ujcej4j4t4RjoMLt3Ss"
        XCTAssertEqual(url.absoluteString, expectedURL)
    }
}
