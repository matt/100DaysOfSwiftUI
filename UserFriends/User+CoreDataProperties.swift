//
//  User+CoreDataProperties.swift
//  UserFriends
//
//  Created by Matthew Mohrman on 12/29/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//
//

import Foundation
import CoreData


extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friends: NSSet?
    @NSManaged public var tags: NSSet?
    
    public var wrappedAbout: String {
        about ?? "Unknown about"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date(timeIntervalSince1970: 0)
    }
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        
        return set.sorted {
            $0.wrappedName > $1.wrappedName
        }
    }
    
    public var tagsArray: [Tag] {
        let set = tags as? Set<Tag> ?? []
        
        return set.sorted {
            $0.wrappedName > $1.wrappedName
        }
    }
    
    var displayAddress: String {
        let addressPieces = wrappedAddress.split(separator: ",")
        
        guard addressPieces.count == 4 else {
            return wrappedAddress
        }
        
        return """
        \(addressPieces[0])
        \(addressPieces[1].trimmingCharacters(in: .whitespaces)),\(addressPieces[2])\(addressPieces[3])1
        """
    }
    
    var displayTags: String {
        tagsArray.map { $0.wrappedName }.joined(separator: ", ")
    }
    
    var displayRegistered: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: wrappedRegistered)
    }
}

// MARK: Generated accessors for friends
extension User {
    
    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)
    
    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)
    
    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)
    
    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)
    
}

// MARK: Generated accessors for tags
extension User {
    
    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)
    
    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)
    
    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)
    
    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)
    
}
