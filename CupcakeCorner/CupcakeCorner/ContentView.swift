//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Matthew Mohrman on 12/19/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

class PointOfSale: ObservableObject {
    @Published var order = Order()
}

struct ContentView: View {
    @ObservedObject var pointOfSale = PointOfSale()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $pointOfSale.order.type) {
                        ForEach(0 ..< Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(pointOfSale.order.quantity)", value: $pointOfSale.order.quantity, in: 3 ... 20)
                }
                
                Section {
                    Toggle(isOn: $pointOfSale.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if pointOfSale.order.specialRequestEnabled {
                        Toggle(isOn: $pointOfSale.order.extraFrosting) {
                            Text("Add extra frosting?")
                        }
                        Toggle(isOn: $pointOfSale.order.addSprinkles) {
                            Text("Add extra sprinkles?")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(pointOfSale: pointOfSale)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
