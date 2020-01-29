//
//  NamedImageDetailsView.swift
//  ImageNamer
//
//  Created by Matthew Mohrman on 1/8/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct NamedImageDetailsView: View {
    let namedImage: NamedImage
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: namedImage.image)
                .resizable()
                .scaledToFit()
                
            MapView(namedImage: namedImage)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle(Text(namedImage.name), displayMode: .inline)
    }
}

struct NamedImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NamedImageDetailsView(namedImage: NamedImage(name: "Name", image: UIImage()))
    }
}
