//
//  ViewController.swift
//  MapKit_2
//
//  Created by Josicleison on 11/10/22.
//

import MapKit
import UIKit

class View: UIViewController {

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
}

