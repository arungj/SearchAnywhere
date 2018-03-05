//
//  ARGSearchResponse.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

/**
 This struct acts as the model for the JSON response.
 It specifies only the keys that are required. All the other keys in the JSON response will be ignored.
 */
struct ARGSearchResponse: Codable {
    let results: [ARGLocationDetails]
}

struct ARGLocationDetails: Codable {
    let formatted_address: String
    let geometry: ARGGeometry
    let place_id: String
}

struct ARGGeometry: Codable {
    let location: ARGLocation
}

struct ARGLocation: Codable {
    let lat: Double
    let lng: Double
}
