//
//  CoreDataProvider.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "ListyModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error initalizing CoreData Model \(error)")
            }
        }
        
    }
    
}
