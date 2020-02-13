//
//  ViewController.swift
//  LocationTesting
//
//  Created by Adem Salih on 12/02/2020.
//  Copyright © 2020 Adem Salih. All rights reserved.
//

import Cocoa
import CoreLocation
import MapKit

class ViewController: NSViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: NSTextField!
    @IBOutlet weak var longitudeLabel: NSTextField!
    @IBOutlet weak var altitudeLabel: NSTextField!
    @IBOutlet weak var horizontalAccuracyLabel: NSTextField!
    @IBOutlet weak var verticalAccuracyLabel: NSTextField!
    @IBOutlet weak var timeStamp: NSTextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // Set MapView options
        mapView.showsZoomControls = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        
        // See is the user has location services enabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
        } else {
            let alert = NSAlert.init()
 			alert.messageText = "You need to enable location services for this application to work correctly."
            alert.informativeText = "Information text"
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Cancel")
            alert.runModal()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("Authorization OK")
            
            if let userLocation = locationManager.location {
                 latitudeLabel.stringValue = userLocation.coordinate.latitude.description
                 longitudeLabel.stringValue = userLocation.coordinate.longitude.description
                 altitudeLabel.stringValue = userLocation.altitude.description
                 horizontalAccuracyLabel.stringValue = userLocation.horizontalAccuracy.description
                 verticalAccuracyLabel.stringValue = userLocation.horizontalAccuracy.description
                 timeStamp.stringValue = userLocation.timestamp.description
                 
                 // Add an annitation to the map view
                 let annotation = MKPointAnnotation()
                 let annotationCoordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude - 0.006, longitude: userLocation.coordinate.longitude - 0.012)
                 annotation.coordinate = annotationCoordinate
                 annotation.title = "Hello World!"
                 annotation.subtitle = "An interesting location..."
                 mapView.addAnnotation(annotation)
                 
                 let zoomLevel = 0.015 /// Lower values zoom in, higher values zoom out
                 
                 let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                 let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel))
                 mapView.setRegion(region, animated: true)
                 
                 mapView.showsUserLocation = true
             }
        } else {
            print("Authorization not granted")
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

