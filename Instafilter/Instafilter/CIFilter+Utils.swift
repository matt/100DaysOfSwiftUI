//
//  CIFilter+Utils.swift
//  Instafilter
//
//  Created by Matthew Mohrman on 1/3/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import CoreImage

extension CIFilter {
    var displayName: String {
        switch name {
        case "CICrystallize":
            return "Crystalize"
        case "CIEdges":
            return "Edges"
        case "CIGaussianBlur":
            return "Gaussian Blur"
        case "CIPixellate":
            return "Pixellate"
        case "CISepiaTone":
            return "Sepia Tone"
        case "CIUnsharpMask":
            return "Unsharp Mask"
        case "CIVignette":
            return "Vignette"
        default:
            return "Unknown"
        }
    }
}
