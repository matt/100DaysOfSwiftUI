//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Matthew Mohrman on 12/19/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var pointOfSale = PointOfSale()
    @State private var dialogTitle = ""
    @State private var dialogMessage = ""
    @State private var showingDialog = false
    @State private var showingNetworkError = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center) {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Your total is $\(self.pointOfSale.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingDialog) {
            Alert(title: Text(dialogTitle), message: Text(dialogMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(pointOfSale.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                self.dialogTitle = "Network error"
                self.dialogMessage = error?.localizedDescription ?? "Unknown error" //Please verify you are connected to a network and try again."
                self.showingDialog = true
                
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.dialogTitle = "Thank you!"
                self.dialogMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) is on its way"
                self.showingDialog = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(pointOfSale: PointOfSale())
    }
}
