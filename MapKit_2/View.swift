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
    
    private let mapView: MKMapView = {

        let mapView = MKMapView()
        mapView.backgroundColor = .systemRed

        return mapView
    }()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        view.addSubview(mapView)

        mapView.constraint(by: [.top,.leading,.trailing,.bottom])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func render(_ location: CLLocation) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        
        mapView.setRegion(MKCoordinateRegion(center: center,
                                             span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                    longitudeDelta: 0.1)),
                          animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        
        mapView.addAnnotation(pin)
    }
}

extension View: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            locationManager.stopUpdatingLocation()
            
            render(location)
        }
    }
}
