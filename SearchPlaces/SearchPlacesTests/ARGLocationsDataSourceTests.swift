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
    
    // Test case when there are no location items in the array.
    func testNoLocation() {
        locationsDataSource = ARGLocationsDataSource()

        let selectedLocation = locationsDataSource.selectedLocation
        XCTAssertNil(selectedLocation, "The selected location should be nil.")
        
        let locationResults = locationsDataSource.locationResults
        XCTAssertNil(locationResults, "The location results array should be nil.")
        
        let mapMode = locationsDataSource.mapMode
        XCTAssertEqual(mapMode, .allAnnotations, "The map mode should be 'allAnnotations'")
        
        let isSelected = locationsDataSource.isSelected(placeID: "abcd")
        XCTAssertFalse(isSelected, "The isSelected function should return false for unknown place ID.")
    }
    
    // Test case when 'locationDetails' array is set and 'selectedLocation' is not set.
    func testShowAllLocation() {
        locationsDataSource = ARGLocationsDataSource()
        
        let locationDetails = ARGLocationDetails(formatted_address: "Apple",
                                                 geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                 place_id: "171229-nE6KAx")
        locationsDataSource.locationResults = [locationDetails]
        let selectedLocation = locationsDataSource.selectedLocation
        XCTAssertNil(selectedLocation, "The selected location should be nil.")
        
        let locationResults = locationsDataSource.locationResults
        XCTAssertNotNil(locationResults, "The location results array should not be nil.")
        
        let mapMode = locationsDataSource.mapMode
        XCTAssertEqual(mapMode, .allAnnotations, "The map mode should be 'allAnnotations'")
    }
    
    // Test case when both 'locationDetails' array and 'selectedLocation' are set.
    func testSelectedLocation() {
        locationsDataSource = ARGLocationsDataSource()
        
        let locationDetails = ARGLocationDetails(formatted_address: "Apple",
                                                 geometry: ARGGeometry(location: ARGLocation(lat: 100, lng: 100)),
                                                 place_id: "171229-nE6KAx")
        locationsDataSource.locationResults = [locationDetails]
        locationsDataSource.selectedLocation = locationDetails
        
        let selectedLocation = locationsDataSource.selectedLocation
        XCTAssertNotNil(selectedLocation, "The selected location should be nil.")
        
        let locationResults = locationsDataSource.locationResults
        XCTAssertNotNil(locationResults, "The location results array should not be nil.")
        
        let mapMode = locationsDataSource.mapMode
        XCTAssertEqual(mapMode, .selectedAnnotation, "The map mode should be 'selectedAnnotation'")
        
        var isSelected = locationsDataSource.isSelected(placeID: "171229-nE6KAx")
        XCTAssertTrue(isSelected, "The isSelected function should return true for known place ID.")
        
        isSelected = locationsDataSource.isSelected(placeID: "nE6KAx")
        XCTAssertFalse(isSelected, "The isSelected function should return false for unknown place ID.")
    }
}
