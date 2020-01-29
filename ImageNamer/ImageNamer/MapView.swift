//
//  MapView.swift
//  ImageNamer
//
//  Created by Matthew Mohrman on 1/8/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    let namedImage: NamedImage
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        if let location = namedImage.location {
            let annotation = MKPointAnnotation()
            annotation.title = namedImage.name
            annotation.coordinate = location

            mapView.addAnnotation(annotation)
            mapView.centerCoordinate = location
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
}
