//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Tyler Stickler on 8/30/17.
//  Copyright © 2017 tstick. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var userLocationBtn: UIButton!
    var updatingLocation: Bool = false
    var shouldSetRegion: Bool = true
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as the view of this view controller
        view = mapView
        
        // Creates a segment controller that allows us to switch between map types
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Sets the top constraint to be under the status bar
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        
        // Sets the leading and trailing constraints to the margins on each side
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // Applies the constraints to the map
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // Updates the map type when the one of the segments is tapped
        segmentedControl.addTarget(self, action: #selector(mapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        // Setting up our button that allows us to track user location
        userLocationBtn = UIButton()
        userLocationBtn.imageEdgeInsets = UIEdgeInsetsMake(40, 40, 40, 40)
        userLocationBtn.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        userLocationBtn.layer.cornerRadius = 25
        userLocationBtn.layer.borderWidth = 1
        userLocationBtn.layer.borderColor = UIColor.blue.cgColor
        userLocationBtn.imageView?.contentMode = .scaleAspectFit
        userLocationBtn.translatesAutoresizingMaskIntoConstraints = false
        userLocationBtn.setImage(UIImage(named: "bluemarker.png"), for: UIControlState.normal)
        userLocationBtn.addTarget(self, action: #selector(locationBtnTapped), for: .touchUpInside)
        view.addSubview(userLocationBtn)
        
        // Setting up our button constraints
        let btnTopConstraint = userLocationBtn.topAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -60)
        //let btnLeadingConstraint = userLocationBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 275)
        let btnTrailingConstraint = userLocationBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        btnTopConstraint.isActive = true
        // btnLeadingConstraint.isActive = true
        btnTrailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initalizes our location manager to find the user
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        print("MapViewController loaded its view")
    }
    
    // Function to switch between map types
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    // Button to begin tracking or stop tracking user location
    func locationBtnTapped() {
        if updatingLocation == false {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            updatingLocation = true
            print("Began tracking user location")
        }
        else {
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
            print("Stopped tracking user location")
            updatingLocation = false
            shouldSetRegion = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gets the users current location
        let userLocation: CLLocation = locations[0]
        
        // Pulls out latitude and longitude from current location and creates a coordinate
        let lat = userLocation.coordinate.latitude
        let lon = userLocation.coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        // Amount of degrees to display on the map
        let latDelta: CLLocationDegrees = 0.015
        let lonDelta: CLLocationDegrees = 0.015
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        // Sets the region according to our coordinates and span
        if shouldSetRegion == true {
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            shouldSetRegion = false
        }
        
        print("\(lat), \(lon)")
    }
}
