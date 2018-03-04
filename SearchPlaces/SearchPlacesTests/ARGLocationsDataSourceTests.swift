//
//  ARGLocationsDataSourceTests.swift
//  SearchPlacesTests
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import XCTest
@testable import SearchPlaces

class ARGLocationsDataSourceTests: XCTestCase {
    var locationsDataSource: ARGLocationsDataSource!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        locationsDataSource = nil
        super.tearDown()
    }
    
    func testNoLocation() {
        locationsDataSource = ARGLocationsDataSource()
        
        let selectedLocation = locationsDataSource.selectedLocation
        XCTAssertNil(selectedLocation)
        
        let locationResults = locationsDataSource.locationResults
        XCTAssertNil(locationResults)
        
        let showAllLocations = locationsDataSource.showAllLocation
        XCTAssertTrue(showAllLocations)
        
        let isSelected = locationsDataSource.isSelected(placeID: "abcd")
        XCTAssertFalse(isSelected)
    }
    
    func testShowAllLocation() {
        locationsDataSource = ARGLocationsDataSource()
        
        let locationDetails = ARGLocationDetails(formatted_address: "Apple",
                                                 geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                 place_id: "adfasfafafa")
        locationsDataSource.locationResults = [locationDetails]
        let selectedLocation = locationsDataSource.selectedLocation
        XCTAssertNil(selectedLocation)
        
        let locationResults = locationsDataSource.locationResults
        XCTAssertNotNil(locationResults)
        
        let showAllLocations = locationsDataSource.showAllLocation
        XCTAssertTrue(showAllLocations)
    }
    
    func testSelectedLocation() {
        locationsDataSource = ARGLocationsDataSource()
        
        let locationDetails = ARGLocationDetails(formatted_address: "Apple",
                                                 geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                 place_id: "adfasfafafa")
        locationsDataSource.locationResults = [locationDetails]
        locationsDataSource.selectedLocation = locationDetails
        
        let selectedLocation = locationsDataSource.selectedLocation
        XCTAssertNotNil(selectedLocation)
        
        let locationResults = locationsDataSource.locationResults
        XCTAssertNotNil(locationResults)
        
        let showAllLocations = locationsDataSource.showAllLocation
        XCTAssertFalse(showAllLocations)
        
        var isSelected = locationsDataSource.isSelected(placeID: "adfasfafafa")
        XCTAssertTrue(isSelected)
        
        isSelected = locationsDataSource.isSelected(placeID: "abcdefg")
        XCTAssertFalse(isSelected)
    }
}
