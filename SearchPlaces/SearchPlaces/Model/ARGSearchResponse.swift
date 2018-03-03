//
//  ARGSearchResponse.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

struct ARGSearchResponse: Codable {
    let results: [ARGResult]
}

struct ARGResult: Codable {
    let formatted_address: String
    let geometry: ARGGeometry
    let place_id: String
}

struct ARGGeometry: Codable {
    let location: ARGLocation
}

struct ARGLocation: Codable {
    let lat: Float
    let lng: Float
}
