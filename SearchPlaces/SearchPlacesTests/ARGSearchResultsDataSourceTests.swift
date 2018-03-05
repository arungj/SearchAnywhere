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
    
    // Test case when 'ARGSearchResultsDataSource' object is initialized with zero search results and no search text.
    func testWithNoSearch() {
        searchResultsDataSource = ARGSearchResultsDataSource()
        
        let numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 0, "The number of rows should be zero.")
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 0, "The number of sections should be zero.")
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertFalse(hasSearchResults, "The search results property should be false.")
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(isLocationAvailable, "The location availability for the row 0 and section 0 should be false.")
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertFalse(isLocationAvailable, "The location availability for the row 0 and section 1 should be false.")
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, searchResultsDataSource.noResults, "The row title is wrong.")
    }
    
    // Test case when 'ARGSearchResultsDataSource' object is initialized with zero search results and a valid search text.
    func testWithNoSearchResult() {
        searchResultsDataSource = ARGSearchResultsDataSource(searchText: "abc", results: [])
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 1, "The number of sections should be equal to one.")
        
        var numberOfRows = searchResultsDataSource.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1, "The number of rows should be one in section zero.")
        
        numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 0, "The number of rows should be zero in section one.")
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertFalse(hasSearchResults, "The search results property should be false.")
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(isLocationAvailable, "The location availability for the row 0 and section 0 should be false.")
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertFalse(isLocationAvailable, "The location availability for the row 0 and section 1 should be false.")
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, searchResultsDataSource.noResults, "The row title is wrong.")
    }
    
    // Test case when 'ARGSearchResultsDataSource' object is initialized with a single search result and a valid search text.
    func testWithSingleSearchResult() {
        let locationDetails = ARGLocationDetails(formatted_address: "Apple",
                                                  geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                  place_id: "171229-nE6KAx")
        searchResultsDataSource = ARGSearchResultsDataSource(searchText: "abc", results: [locationDetails])
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 1, "The number of sections should be equal to one.")
        
        var numberOfRows = searchResultsDataSource.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1, "The number of rows should be one in section zero.")
        
        numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 0, "The number of rows should be zero in section one.")
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertTrue(hasSearchResults, "The search results property should be true.")
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(isLocationAvailable, "The location availability for the row 0 and section 0 should be true.")
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertTrue(isLocationAvailable, "The location availability for the row 0 and section 1 should be true.")
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, "Apple", "The row title should be 'Apple'.")
    }
    
    // Test case when 'ARGSearchResultsDataSource' object is initialized with multiple search results and a valid search text.
    func testWithMultipleSearchResults() {
        let locationDetails1 = ARGLocationDetails(formatted_address: "Apple",
                                                  geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                  place_id: "171229-nE6KAx")
        let locationDetails2 = ARGLocationDetails(formatted_address: "Google",
                                                  geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                  place_id: "qgl1dl099n4l")
        searchResultsDataSource = ARGSearchResultsDataSource(searchText: "abc", results: [locationDetails1, locationDetails2])
        
        let numberOfRows = searchResultsDataSource.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 2, "The number of rows should be two in section one.")
        
        let numberOfSections = searchResultsDataSource.numberOfSections
        XCTAssertEqual(numberOfSections, 2, "The number of sections should be equal to two.")
        
        let hasSearchResults = searchResultsDataSource.hasSearchResults
        XCTAssertTrue(hasSearchResults, "The search results property should be true.")
        
        var isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 1))
        XCTAssertTrue(isLocationAvailable, "The location availability for the row 0 and section 1 should be true.")
        
        isLocationAvailable = searchResultsDataSource.isLocationAvailable(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(isLocationAvailable, "The location availability for the row 0 and section 0 should be false.")
        
        let rowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowTitle, searchResultsDataSource.displayAllOnMap, "The row title is wrong.")
        
        let firstRowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 0, section: 1))
        XCTAssertEqual(firstRowTitle, "Apple", "The row title should be 'Apple'.")
        
        let secondRowTitle = searchResultsDataSource.titleFor(indexPath: IndexPath(row: 1, section: 1))
        XCTAssertEqual(secondRowTitle, "Google", "The row title should be 'Google'.")
    }
}
