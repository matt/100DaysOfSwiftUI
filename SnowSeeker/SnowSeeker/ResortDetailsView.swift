//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Matthew Mohrman on 1/23/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Size: \(Resort.sizes[resort.size, default: ""])").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(Resort.prices[resort.price, default: ""])").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
