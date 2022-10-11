//
//  ViewController.swift
//  MapKit_2
//
//  Created by Josicleison on 11/10/22.
//

import CoreLocation
import MapKit
import UIKit

class View: UIViewController {

    private let locationManager = CLLocationManager()
    
    private let map: (view: MKMapView, location: (CLLocation)->()) = {
        
        let map = MKMapView()
        map.backgroundColor = .systemRed
        
        let location = {(location: CLLocation) in
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
            
            map.setRegion(MKCoordinateRegion(center: center,
                                                 span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                        longitudeDelta: 0.1)),
                              animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = location.coordinate
            
            map.addAnnotation(pin)
        }

        return (view: map, location: location)
    }()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        view.addSubview(map.view)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        map.view.constraint(by: [.top,.leading,.trailing,.bottom])
    }
}

extension View: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            locationManager.stopUpdatingLocation()
            
            map.location(location)
        }
    }
}
