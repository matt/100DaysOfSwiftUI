//
//  Friend+CoreDataClass.swift
//  UserFriends
//
//  Created by Matthew Mohrman on 12/29/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {
            fatalError()
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context) else {
            fatalError()
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
