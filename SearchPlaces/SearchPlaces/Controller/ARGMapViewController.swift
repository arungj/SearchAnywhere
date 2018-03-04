//
//  ARGMapViewController.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import MapKit

class ARGMapViewController: UIViewController {
    static let storyboardIdentifier = "ARGMapViewController"
    static let annotationViewIdentifier = "AnnotationView"
    
    @IBOutlet weak var mapView: MKMapView!
    var datasource = ARGLocationsDataSource()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnnotations()
    }
    
    func showAnnotations() {
        if mapView.annotations.count > 0 { return }
        
        var annotations = [ARGPinAnnotation]()
        var annotationToHighlight: ARGPinAnnotation?
        datasource.locationResults.forEach { locationDetails in
            let annotation = makeAnnotation(from: locationDetails)
            annotations.append(annotation)
            if datasource.isSelected(placeId: locationDetails.place_id) {
                annotationToHighlight = annotation
            }
        }
        
        if datasource.showAllLocation {
            mapView.showAnnotations(annotations, animated: true)
        } else if let annotation = annotationToHighlight {
            mapView.addAnnotations(annotations)
            let region = MKCoordinateRegion(center: annotation.coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            mapView.setRegion(region, animated: true)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    func makeAnnotation(from locationDetails: ARGLocationDetails) -> ARGPinAnnotation {
        let location = locationDetails.geometry.location
        let coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        return ARGPinAnnotation(title: locationDetails.formatted_address,
                                placeID: locationDetails.place_id,
                                locationName: "(\(location.lat), \(location.lng))",
            coordinate: coordinate)
    }
}

extension ARGMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView
        let identifier = ARGMapViewController.annotationViewIdentifier
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.image = #imageLiteral(resourceName: "pin")
            annotationView.canShowCallout = true
        }
        return annotationView
    }
}
