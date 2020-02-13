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
    @IBAction func updateLocationButtonAction(_ sender: Any) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if let userLocation = locationManager.location {
            latitudeLabel.stringValue = userLocation.coordinate.latitude.description
            longitudeLabel.stringValue = userLocation.coordinate.longitude.description
            altitudeLabel.stringValue = userLocation.altitude.description
            horizontalAccuracyLabel.stringValue = userLocation.horizontalAccuracy.description
            verticalAccuracyLabel.stringValue = userLocation.horizontalAccuracy.description
            timeStamp.stringValue = userLocation.timestamp.description
            
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = "Your Location"
            mapView.addAnnotation(annotation)
            
            let zoomLevel = 0.01
            
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel))
            mapView.setRegion(region, animated: true)
            
            mapView.showsZoomControls = false
            mapView.showsScale = false
            mapView.showsCompass = false
            mapView.showsTraffic = true
            mapView.showsBuildings = true
        }

    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

