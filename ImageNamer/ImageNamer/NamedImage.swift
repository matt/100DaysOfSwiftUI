//
//  NamedImage.swift
//  ImageNamer
//
//  Created by Matthew Mohrman on 1/8/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import CoreLocation
import UIKit
import SwiftUI

enum ImageError: Error {
    case unableToInitialize
    case unableToConvertToJPEGData
}

struct NamedImage: Identifiable {
    var id = UUID()
    var name: String
    var image: UIImage
    var location: CLLocationCoordinate2D?
}
    
extension NamedImage: Codable {
    enum CodingKeys: CodingKey {
        case id, name, imageData, latitude, longitude
    }
    
    init(name: String, image: UIImage, location: CLLocationCoordinate2D?) {
        self.name = name
        self.image = image
        self.location = location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let imageData = try container.decode(Data.self, forKey: .imageData)
        guard let uiImage = UIImage(data: imageData) else {
            throw ImageError.unableToInitialize
        }
        image = uiImage
        if let latitude = try? container.decode(CLLocationDegrees.self, forKey: .latitude),
            let longitude = try? container.decode(CLLocationDegrees.self, forKey: .longitude) {
            location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.unableToConvertToJPEGData
        }
        try container.encode(imageData, forKey: .imageData)
        try container.encodeIfPresent(location?.latitude, forKey: .latitude)
        try container.encodeIfPresent(location?.longitude, forKey: .longitude)
    }
}

extension NamedImage: Comparable {
    static func == (lhs: NamedImage, rhs: NamedImage) -> Bool {
        lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.image == rhs.image &&
            lhs.location?.latitude == rhs.location?.latitude &&
            lhs.location?.longitude == rhs.location?.longitude
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
}
