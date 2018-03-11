//
//  ARGMapViewController.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import MapKit

/**
 The modes defined for displaying the annotations on the map. Currently there are 2 modes.
 */
enum ARGAnnotationMode {
    case allAnnotations     // Specifies that all annotations will be shown on the map.
    case selectedAnnotation // This mode specifies that a location is chosen by the user to see on the map. Save / delete option is enabled in this mode.
}

/**
 This ViewController shows the map view and loads the annotations, provides save / delete option for places.
 */
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
    
    /**
     Display the annotations when the ViewController loads. Iterate through the 'locationResults' array and create each annotation.
     If the mode is 'all annotations', then show all annotations with animation. Else show only the selected annotation centered on the screen.
     */
    func showAnnotations() {
        if !mapView.annotations.isEmpty { return }
        
        var annotations = [ARGPinAnnotation]()
        var annotationToHighlight: ARGPinAnnotation?
        // Iterate through the locations and create the annotation.
        datasource.locationResults?.forEach { locationDetails in
            let annotation = makeAnnotation(from: locationDetails)
            annotations.append(annotation)
            if datasource.isSelected(placeID: locationDetails.place_id) {
                annotationToHighlight = annotation
            }
        }
        
        // Below code shows all annotations on the map view based on the current mode.
        if datasource.mapMode == .allAnnotations {
            mapView.showAnnotations(annotations, animated: true)
        } else if let annotation = annotationToHighlight {
            // Add all annotations on the map view and open callout the for the selected one.
            mapView.addAnnotations(annotations)
            // Center the map at the location of the selected annotation.
            setMapRegion(with: annotation.coordinate)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    // Set the map region with a coordinate. Called only for the selected annotations mode.
    func setMapRegion(with coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        mapView.setRegion(region, animated: true)
    }
    
    /**
     This method creates a pin annotation from the location details provided.
     - parameter locationDetails: The location object containing the place details and lat-long.
     - returns: An annotation for the given location.
     */
    func makeAnnotation(from locationDetails: ARGLocationDetails) -> ARGPinAnnotation {
        let location = locationDetails.geometry.location
        let coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        return ARGPinAnnotation(title: locationDetails.formatted_address,
                                placeID: locationDetails.place_id,
                                locationName: "(\(location.lat), \(location.lng))",
            coordinate: coordinate)
    }
    
    /**
     This method shows a Save / Delete button on the navigation bar based on the saved status of the location.
     */
    func updateNavigationButton() {
        guard let placeID = datasource.selectedLocation?.place_id else { return }
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
    }
    
    /**
     This button action calls the save / delete operation and updates the Navigation bar image.
     */
    @objc func didTapBarButton() {
        saveOrRemovePlace()
        updateNavigationButton()
    }
    
    /**
     This method performs the save / delete operation in CoreData based on the current saved status of the selected location.
     */
    func saveOrRemovePlace() {
        guard let selectedPlace = datasource.selectedLocation else { return }
        
        if isSaved(placeID: selectedPlace.place_id) {
            deletePlace(forPlaceID: selectedPlace.place_id)
        } else {
            save(placeDetails: selectedPlace)
        }
    }
}

extension ARGMapViewController: MKMapViewDelegate {
    /**
     This method customizes the annotation displayed on the screen with a custom pin image.
     */
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
    
    /**
     Update the Navigation bar save / delete button if an annotation is tapped. Only for 'selected annotation' mode.
     */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? ARGPinAnnotation,
            datasource.mapMode == .selectedAnnotation {
            datasource.selectedLocation = datasource.location(fromPlaceID: annotation.placeID)
            updateNavigationButton()
        }
    }
}
