//
//  Car+CoreDataProperties.swift
//  0422-CoreData
//
//  Created by mac07 on 2020/4/23.
//  Copyright © 2020 mac07. All rights reserved.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var plate: String?
    @NSManaged public var belongto: UserData?

}
