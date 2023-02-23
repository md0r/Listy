//
//  MyList+CoreDataClass.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import Foundation
import CoreData
import UIKit

@objc(MyList)
public class MyList: NSManagedObject {
    
}

extension MyList {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
    
    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var reminders: NSSet?
    
}

extension MyList: Identifiable {
    
}

extension MyList {
    
    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)
    
    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)
    
    @objc(addReminders:)
    @NSManaged public func addToReminders(_ value: NSSet)
    
    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ value: NSSet)
    
}
