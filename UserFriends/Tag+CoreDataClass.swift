//
//  Tag+CoreDataClass.swift
//  UserFriends
//
//  Created by Matthew Mohrman on 12/29/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {
            fatalError()
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Tag", in: context) else {
            fatalError()
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.singleValueContainer()
        
        self.name = try container.decode(String.self)
    }
}
