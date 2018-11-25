//
//  Person+CoreDataClass.swift
//  CoreDataAppDemo
//
//  Created by Bhushan Udawant on 17/11/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//
//

import Foundation
import CoreData


public class Person: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var dob: NSDate?


    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }
}
