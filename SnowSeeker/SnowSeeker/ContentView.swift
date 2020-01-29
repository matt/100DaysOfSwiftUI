//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Matthew Mohrman on 1/23/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var sortBy: SortBy?
    @State private var filters = [FilterBy]()
    @State private var showingSortBy = false
    @State private var showingFilterBy = false
    
    enum SortBy: String {
        case alphabetical, country
    }
    
    enum FilterBy {
        case country(String), size(Int), price(Int)
    }
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var sortedAndFilteredResorts: [Resort] {
        var resorts = self.resorts
        
        switch sortBy {
        case .some(.alphabetical):
            resorts.sort { $0.name < $1.name }
        case .some(.country):
            resorts.sort { $0.country < $1.country }
        case .none:
            break
        }
        
        for filter in filters {
            switch filter {
            case .country(let country):
                resorts = resorts.filter { $0.country == country }
            case .size(let size):
                resorts = resorts.filter { $0.size == size }
            case .price(let price):
                resorts = resorts.filter { $0.price == price }
            }
        }
        
        return resorts
    }
    
    var body: some View {
        NavigationView {
            List(sortedAndFilteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                    )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                    )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading:
                Button("Sort") {
                    self.showingSortBy = true
                }
                , trailing:
                Button("Filter") {
                    self.showingFilterBy = true
                }
            )
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .actionSheet(isPresented: $showingSortBy) {
            ActionSheet(title: Text("Sort by"), message: nil, buttons: [
                ActionSheet.Button.default(Text("Default")) {
                    self.sortBy = nil
                },
                ActionSheet.Button.default(Text(String(SortBy.alphabetical.rawValue).capitalized)) {
                    self.sortBy = .alphabetical
                },
                ActionSheet.Button.default(Text(String(SortBy.country.rawValue).capitalized)) {
                    self.sortBy = .country
                },
                ActionSheet.Button.cancel()
            ])
        }
        .sheet(isPresented: $showingFilterBy) {
            FilterView(filters: self.$filters)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
