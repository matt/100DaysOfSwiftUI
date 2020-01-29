//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Matthew Mohrman on 1/23/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var filters: [ContentView.FilterBy]
    
    @State private var filteredCountry = ""
    @State private var filteredSize = ""
    @State private var filteredPrice = ""
    
    let all: String
    let countries: [String]
    let sizes: [String]
    let prices: [String]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Country", selection: $filteredCountry) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                    Picker("Size", selection: $filteredSize) {
                        ForEach(sizes, id: \.self) { size in
                            Text(Resort.sizes[Int(size) ?? Int.min, default: size])
                        }
                    }
                    Picker("Price", selection: $filteredPrice) {
                        ForEach(prices, id: \.self) { price in
                            Text(Resort.prices[Int(price) ?? Int.min, default: price])
                        }
                    }
                }
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                , trailing:
                Button("Save") {
                    var filters = [ContentView.FilterBy]()
                    
                    if self.filteredCountry != self.all {
                        filters.append(.country(self.filteredCountry))
                    }
                    
                    if let filteredSize = Int(self.filteredSize) {
                        filters.append(.size(filteredSize))
                    }
                    
                    if let filteredPrice = Int(self.filteredPrice) {
                        filters.append(.price(filteredPrice))
                    }
                    
                    self.filters = filters
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    init(filters: Binding<[ContentView.FilterBy]>) {
        let all = "All"
        var filteredCountry = State(initialValue: all)
        var filteredSize = State(initialValue: all)
        var filteredPrice = State(initialValue: all)
        
        for filter in filters.wrappedValue {
            switch filter {
            case .country(let country):
                filteredCountry = State(initialValue: country)
            case .size(let size):
                filteredSize = State(initialValue: String(size))
            case .price(let price):
                filteredPrice = State(initialValue: String(price))
            }
        }
        
        self.all = all
        countries = [all] + Array(Set(Resort.allResorts.map { $0.country })).sorted()
        sizes = [all] + Resort.sizes.keys.map(String.init).sorted()
        prices = [all] + Resort.prices.keys.map(String.init).sorted()
        
        _filters = filters
        _filteredCountry = filteredCountry
        _filteredSize = filteredSize
        _filteredPrice = filteredPrice
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filters: .constant([]))
    }
}
