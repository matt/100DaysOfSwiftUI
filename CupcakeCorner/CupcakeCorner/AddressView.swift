//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Matthew Mohrman on 12/19/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var pointOfSale: PointOfSale
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $pointOfSale.order.name)
                TextField("Street Address", text: $pointOfSale.order.streetAddress)
                TextField("City", text: $pointOfSale.order.city)
                TextField("Zip", text: $pointOfSale.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(pointOfSale: pointOfSale)) {
                    Text("Check out")
                }
            }
            .disabled(pointOfSale.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(pointOfSale: PointOfSale())
    }
}
