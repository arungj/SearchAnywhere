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
    
    // This method creates the object for the location details and saves it to CoreData.
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
    
    // This method check if the location with the specified place ID exists in CoreData.
    func isSaved(placeID: String) -> Bool {
        if placeDetails(forPlaceID: placeID) != nil { return true }
        return false
    }
    
    // This method return a 'Place' object from CoreData that matches the place ID.
    func placeDetails(forPlaceID placeID: String) -> Place? {
        let predicate = NSPredicate(format: "placeID == %@", placeID)
        let places = fetchPlaces(with: predicate)
        return places?.first
    }
    
    // This method deletes a place record from CoreData.
    func deletePlace(forPlaceID placeID: String) {
        if let place = placeDetails(forPlaceID: placeID) {
            ARGCoreDataManager.shared.context?.delete(place)
            ARGCoreDataManager.shared.saveContext()
        }
    }
    
    // This method fetches all the places from CoreData that matches the predicate.
    func fetchPlaces(with predicate: NSPredicate? = nil) -> [Place]? {
        guard let context = ARGCoreDataManager.shared.context else { return [] }
        let fetchRequest = Place.currentFetchRequest()
        fetchRequest.predicate = predicate
        return try? context.fetch(fetchRequest)
    }
}
