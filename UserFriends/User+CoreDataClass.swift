//
//  User+CoreDataClass.swift
//  UserFriends
//
//  Created by Matthew Mohrman on 12/29/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case about
        case address
        case age
        case company
        case email
        case id
        case isActive
        case name
        case registered
        case friends
        case tags
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {
            fatalError()
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else {
            fatalError()
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let about = try container.decode(String.self, forKey: .about)
        self.about = about.trimmingCharacters(in: .whitespacesAndNewlines)
        self.address = try container.decode(String.self, forKey: .address)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.registered = try container.decode(Date.self, forKey: .registered)
        let friendsArray = try container.decode([Friend].self, forKey: .friends)
        self.friends = NSSet(array: friendsArray)
        let tagsArray = try container.decode([Tag].self, forKey: .tags)
        self.tags = NSSet(array: tagsArray)
    }
}

extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}
