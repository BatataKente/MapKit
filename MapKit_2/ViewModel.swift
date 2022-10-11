//
//  ViewModel.swift
//  MapKit_2
//
//  Created by Josicleison on 11/10/22.
//

import MapKit
import CoreLocation
import Foundation

protocol ViewModelDelegate: AnyObject {
    
    func setMap(_ center: CLLocationCoordinate2D, pins: [MKPointAnnotation])
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    func setLocation(_ location: CLLocation) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        
        delegate?.setMap(center, pins: [pin])
    }
}
