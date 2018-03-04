//
//  Place+CoreDataProperties.swift
//  SearchPlaces
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//
//

import CoreData

extension Place {

    @nonobjc public class func currentFetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var address: String
    @NSManaged public var placeID: String
}
