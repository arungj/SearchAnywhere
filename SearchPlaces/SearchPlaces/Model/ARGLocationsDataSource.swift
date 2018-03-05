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
    
    var mapMode: ARGAnnotationMode {
        if selectedLocation != nil {
            return .selectedAnnotation
        }
        return .allAnnotations
    }
    
    func isSelected(placeID: String) -> Bool {
        if mapMode == .selectedAnnotation,
            let selectedLocation = selectedLocation {
            if selectedLocation.place_id == placeID {
                return true
            }
        }
        return false
    }
    
    func location(fromPlaceID placeID: String) -> ARGLocationDetails? {
        for location in locationResults {
            if location.place_id == placeID {
                return location
            }
        }
        return nil
    }
}
