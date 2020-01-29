//
//  NameSelectedImageView.swift
//  ImageNamer
//
//  Created by Matthew Mohrman on 1/8/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct NameSelectedImageView: View {
    @Environment(\.presentationMode) var presentationMode
    var selectedImage: UIImage
    @Binding var name: String
    
    @State private var editableName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    Image(uiImage: self.selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.width * 9 / 16)
                }
                Form {
                    Section {
                        TextField("Name", text: $editableName)
                    }
                }
            }
            .navigationBarTitle(Text("Name selected image"))
            .navigationBarItems(trailing:
                Button("Save") {
                    self.name = self.editableName
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(editableName.isEmpty)
            )
        }
    }
}

struct NameSelectedImageView_Previews: PreviewProvider {
    static var previews: some View {
        NameSelectedImageView(selectedImage: UIImage(), name: .constant(""))
    }
}
