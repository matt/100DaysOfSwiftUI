//
//  ContentView.swift
//  ImageNamer
//
//  Created by Matthew Mohrman on 1/8/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let locationFetcher = LocationFetcher()
    
    @State private var namedImages = [NamedImage]()
    @State private var showingImagePicker = false
    @State private var showingNameSelectedImage = false
    @State private var name = ""
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(namedImages) { namedImage in
                    NavigationLink(destination: NamedImageDetailsView(namedImage: namedImage)) {
                        HStack {
                            Image(uiImage: namedImage.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            Text(namedImage.name)
                                .font(.title)
                        }
                    }
                }
            }
            .navigationBarTitle("Image Namer")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingImagePicker = true
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: {
                    self.showingNameSelectedImage = true
                }) {
                    ImagePicker(uiImage: self.$selectedImage)
                }
            )
        }
        .sheet(isPresented: $showingNameSelectedImage, onDismiss: {
            guard let selectedImage = self.selectedImage, self.name.isEmpty == false else {
                self.name = ""
                self.selectedImage = nil
                return
            }
            
            let namedImage = NamedImage(name: self.name, image: selectedImage, location: self.locationFetcher.lastKnownLocation)
            self.namedImages.append(namedImage)
            
            self.saveData()
        }) {
            NameSelectedImageView(selectedImage: self.selectedImage!, name: self.$name)
        }
        .onAppear {
            self.locationFetcher.start()
            self.loadData()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        do {
            let url = self.getDocumentsDirectory().appendingPathComponent("namedImages")
            let data = try JSONEncoder().encode(self.namedImages)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
        
        name = ""
        selectedImage = nil
    }
    
    func loadData() {
        do {
            let url = getDocumentsDirectory().appendingPathComponent("namedImages")
            let data = try Data(contentsOf: url)
            let unsortedNamedImages = try JSONDecoder().decode([NamedImage].self, from: data)
            namedImages = unsortedNamedImages.sorted()
        } catch {
            print("Unable to load data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
