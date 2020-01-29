//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Matthew Mohrman on 1/6/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            title ?? "Unknown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubTitle: String {
        get {
            subtitle ?? "Unknown value"
        }
        
        set {
            subtitle = newValue
        }
    }
}
