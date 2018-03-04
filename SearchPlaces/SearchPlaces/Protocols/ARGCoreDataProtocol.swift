//
//  ARGCoreDataProtocol.swift
//  SearchPlaces
//
//  Created by Arun George on 3/4/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import CoreData

protocol ARGCoreDataProtocol { }

extension ARGCoreDataProtocol {
    func save(placeDetails: ARGLocationDetails) {
        guard let context = ARGCoreDataManager.shared.context else { return }
        var placeObject: Place?
        if #available(iOS 10, *) {
            placeObject = Place(context: context)
        } else {
            if let placeEntity = NSEntityDescription.entity(forEntityName: "Place", in: context) {
                placeObject = Place(entity: placeEntity, insertInto: context)
            }
        }
        if let place = placeObject {
            place.address = placeDetails.formatted_address
            place.placeID = placeDetails.place_id
            place.latitude = placeDetails.geometry.location.lat
            place.longitude = placeDetails.geometry.location.lng
            ARGCoreDataManager.shared.saveContext()
        }
    }
    
    func isSaved(placeID: String) -> Bool {
        if placeDetails(forPlaceID: placeID) != nil { return true }
        return false
    }
    
    func placeDetails(forPlaceID placeID: String) -> Place? {
        let predicate = NSPredicate(format: "placeID == %@", placeID)
        let places = fetchPlaces(with: predicate)
        return places?.first
    }
    
    func deletePlace(forPlaceID placeID: String) {
        if let place = placeDetails(forPlaceID: placeID) {
            ARGCoreDataManager.shared.context?.delete(place)
            ARGCoreDataManager.shared.saveContext()
        }
    }
    
    func fetchPlaces(with predicate: NSPredicate? = nil) -> [Place]? {
        guard let context = ARGCoreDataManager.shared.context else { return [] }
        let fetchRequest = Place.currentFetchRequest()
        fetchRequest.predicate = predicate
        return try? context.fetch(fetchRequest)
    }
}
