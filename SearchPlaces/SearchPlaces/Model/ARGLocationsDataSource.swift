//
//  ARGLocationsDataSource.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

struct ARGLocationsDataSource {
    var locationResults: [ARGLocationDetails]!
    var selectedLocation: ARGLocationDetails?
    
    // The current map mode. It depends on the value of the 'selectedLocation'.
    var mapMode: ARGAnnotationMode {
        if selectedLocation != nil {
            return .selectedAnnotation
        }
        return .allAnnotations
    }
    
    // Checks if the place ID is same as the place ID of the selected location.
    func isSelected(placeID: String) -> Bool {
        if mapMode == .selectedAnnotation,
            let selectedLocation = selectedLocation {
            if selectedLocation.place_id == placeID {
                return true
            }
        }
        return false
    }
    
    // This method searches the 'locationResults' array and returns the location details if the place ID mathches.
    func location(fromPlaceID placeID: String) -> ARGLocationDetails? {
        for location in locationResults {
            if location.place_id == placeID {
                return location
            }
        }
        return nil
    }
}
