//
//  ViewController.swift
//  MapKit_2
//
//  Created by Josicleison on 11/10/22.
//

import MapKit
import UIKit

class View: UIViewController {

    private let locationManager = CLLocationManager()
    private let viewModel = ViewModel()
    
    private let map: MKMapView = {
        
        let map = MKMapView()
        map.backgroundColor = .systemRed

        return map
    }()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        view.addSubview(map)

        map.constraint(by: [.top,.leading,.trailing,.bottom])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        viewModel.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension View: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            locationManager.stopUpdatingLocation()
            
            viewModel.setLocation(location)
        }
    }
}

extension View: ViewModelDelegate {
    
    func setMap(_ center: CLLocationCoordinate2D, pins: [MKPointAnnotation]) {
        
        map.setRegion(MKCoordinateRegion(center: center,
                                         span: MKCoordinateSpan(latitudeDelta: 0.1,
                                        longitudeDelta: 0.1)),
                      animated: true)
        for pin in pins {map.addAnnotation(pin)}
    }
}
