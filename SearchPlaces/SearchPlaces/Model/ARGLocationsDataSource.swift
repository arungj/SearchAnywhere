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
    
    var showAllLocation: Bool {
        return selectedLocation == nil
    }
    
    func isSelected(placeId: String) -> Bool {
        if !showAllLocation,
            let selectedLocation = selectedLocation {
            if selectedLocation.place_id == placeId {
                return true
            }
        }
        return false
    }
}
