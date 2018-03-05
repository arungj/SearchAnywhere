//
//  ARGSearchResultsDataSourceTests.swift
//  SearchPlacesTests
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import XCTest
@testable import SearchPlaces

class ARGSearchResultsDataSourceTests: XCTestCase {
    var searchResultsDataSource: ARGSearchResultsDataSource!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        searchResultsDataSource = nil
        super.tearDown()
    }
    
    func testWithNoSearch() {
        searchResultsDataSource = ARGSearchResultsDataSource()
        
        let numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 0)
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 0)
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertFalse(hasSearchResults)
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(isLocationAvailable)
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertFalse(isLocationAvailable)
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, searchResultsDataSource.noResults)
    }
    
    func testWithNoSearchResult() {
        searchResultsDataSource = ARGSearchResultsDataSource(searchText: "abc", results: [])
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
        
        var numberOfRows = searchResultsDataSource.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        
        numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 0)
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertFalse(hasSearchResults)
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(isLocationAvailable)
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertFalse(isLocationAvailable)
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, searchResultsDataSource.noResults)
    }
    
    func testWithSingleSearchResult() {
        let locationDetails = ARGLocationDetails(formatted_address: "Apple",
                                                  geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                  place_id: "171229-nE6KAx")
        searchResultsDataSource = ARGSearchResultsDataSource(searchText: "abc", results: [locationDetails])
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
        
        var numberOfRows = searchResultsDataSource.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        
        numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 0)
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertTrue(hasSearchResults)
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(isLocationAvailable)
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertTrue(isLocationAvailable)
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, "Apple")
    }
    
    func testWithMultipleSearchResults() {
        let locationDetails1 = ARGLocationDetails(formatted_address: "Apple",
                                                  geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                  place_id: "171229-nE6KAx")
        let locationDetails2 = ARGLocationDetails(formatted_address: "Google",
                                                  geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                  place_id: "qgl1dl099n4l")
        searchResultsDataSource = ARGSearchResultsDataSource(searchText: "abc", results: [locationDetails1, locationDetails2])
        
        let numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 2)
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssert(hasSearchResults)
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertTrue(isLocationAvailable)
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(isLocationAvailable)
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, searchResultsDataSource.displayAllOnMap)
        
        let firstRowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 1))
        XCTAssertEqual(firstRowTitle, "Apple")
        
        let secondRowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 1, section: 1))
        XCTAssertEqual(secondRowTitle, "Google")
    }
}
