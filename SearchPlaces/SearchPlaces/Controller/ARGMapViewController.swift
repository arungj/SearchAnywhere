//
//  ARGMapViewController.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import MapKit

class ARGMapViewController: UIViewController, ARGCoreDataProtocol {
    static let storyboardIdentifier = "ARGMapViewController"
    static let annotationViewIdentifier = "AnnotationView"
    
    @IBOutlet weak var mapView: MKMapView!
    var datasource = ARGLocationsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Results"
    }
    
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
            if datasource.isSelected(placeID: locationDetails.place_id) {
                annotationToHighlight = annotation
            }
        }
        
        // Show all annotations on the map view.
        if datasource.showAllLocation {
            mapView.showAnnotations(annotations, animated: true)
        } else if let annotation = annotationToHighlight {
            // Add all annotations on the map view and open callout for the selected one.
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
    
    func updateNavigationButton(forPlaceID placeID: String) {
        if datasource.isSelected(placeID: placeID) {
            let barButtonIcon: UIBarButtonSystemItem
            if isSaved(placeID: placeID) {
                barButtonIcon = .trash
            } else {
                barButtonIcon = .save
            }
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: barButtonIcon,
                                                target: self,
                                                action: #selector(didTapBarButton))
            navigationItem.rightBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func didTapBarButton() {
        guard let selectedPlace = datasource.selectedLocation else { return }
        
        if isSaved(placeID: selectedPlace.place_id) {
            deletePlace(forPlaceID: selectedPlace.place_id)
        } else {
            save(placeDetails: selectedPlace)
        }
        updateNavigationButton(forPlaceID: selectedPlace.place_id)
    }
}

extension ARGMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = ARGMapViewController.annotationViewIdentifier
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView != nil {
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.image = #imageLiteral(resourceName: "pin")
            annotationView?.canShowCallout = true
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? ARGPinAnnotation {
            updateNavigationButton(forPlaceID: annotation.placeID)
        }
    }
}
