//
//  ARGEnvironment.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

class ARGEnvironment {
    let serviceEndpoint = "https://maps.googleapis.com/maps/api/geocode/json?address="
    let apiKey = "AIzaSyB04cCisFvaUn-_ujcej4j4t4RjoMLt3Ss"
    
    func serviceURL(forSearchText searchText: String) -> URL {
        // Replace spaces in the search text with plus symbol.
        let text = searchText.replacingOccurrences(of: " ", with: "+")
        
        // Construct the URL by appending the search text and API key.
        let urlText = "\(serviceEndpoint)\(text)&key=\(apiKey)"
        
        return URL(string: urlText)!
    }
}
