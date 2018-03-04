//
//  ARGPinAnnotation.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import MapKit

class ARGPinAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let placeID: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, placeID: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.placeID = placeID
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
