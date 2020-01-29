//
//  AuthenticatedView.swift
//  BucketList
//
//  Created by Matthew Mohrman on 1/6/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import MapKit
import SwiftUI

struct AuthenticatedView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditPlace: Bool
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: self.locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example Location"
                        newLocation.coordinate = self.centerCoordinate
                        
                        self.locations.append(newLocation)
                        
                        self.selectedPlace = newLocation
                        self.showingEditPlace = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView(centerCoordinate: .constant(CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)), locations: .constant([]), selectedPlace: .constant(nil), showingPlaceDetails: .constant(false), showingEditPlace: .constant(false))
    }
}
