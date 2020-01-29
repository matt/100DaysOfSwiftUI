//
//  Roll+CoreDataProperties.swift
//  RollDice
//
//  Created by Matthew Mohrman on 1/22/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var created: Date?
    @NSManaged public var dice: NSOrderedSet?
    
    public var wrappedCreated: Date {
        created ?? Date(timeIntervalSince1970: 0)
    }

    public var diceArray: [Dice] {
        dice?.array as? [Dice] ?? []
    }
}

// MARK: Generated accessors for dice
extension Roll {

    @objc(insertObject:inDiceAtIndex:)
    @NSManaged public func insertIntoDice(_ value: Dice, at idx: Int)

    @objc(removeObjectFromDiceAtIndex:)
    @NSManaged public func removeFromDice(at idx: Int)

    @objc(insertDice:atIndexes:)
    @NSManaged public func insertIntoDice(_ values: [Dice], at indexes: NSIndexSet)

    @objc(removeDiceAtIndexes:)
    @NSManaged public func removeFromDice(at indexes: NSIndexSet)

    @objc(replaceObjectInDiceAtIndex:withObject:)
    @NSManaged public func replaceDice(at idx: Int, with value: Dice)

    @objc(replaceDiceAtIndexes:withDice:)
    @NSManaged public func replaceDice(at indexes: NSIndexSet, with values: [Dice])

    @objc(addDiceObject:)
    @NSManaged public func addToDice(_ value: Dice)

    @objc(removeDiceObject:)
    @NSManaged public func removeFromDice(_ value: Dice)

    @objc(addDice:)
    @NSManaged public func addToDice(_ values: NSOrderedSet)

    @objc(removeDice:)
    @NSManaged public func removeFromDice(_ values: NSOrderedSet)

}
