//
//  UserData+CoreDataProperties.swift
//  0422-CoreData
//
//  Created by mac07 on 2020/4/23.
//  Copyright © 2020 mac07. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var cid: String?
    @NSManaged public var cimage: Data?
    @NSManaged public var cname: String?
    @NSManaged public var own: NSSet?

}

// MARK: Generated accessors for own
extension UserData {

    @objc(addOwnObject:)
    @NSManaged public func addToOwn(_ value: Car)

    @objc(removeOwnObject:)
    @NSManaged public func removeFromOwn(_ value: Car)

    @objc(addOwn:)
    @NSManaged public func addToOwn(_ values: NSSet)

    @objc(removeOwn:)
    @NSManaged public func removeFromOwn(_ values: NSSet)

}
