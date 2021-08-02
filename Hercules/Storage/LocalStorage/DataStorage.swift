//
//  DataStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import CoreData

class DataStorage {
    
    static var shared: DataStorage = DataStorage()
    
    private let persistentContainer: NSPersistentContainer
    private let containerName: String
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func convertURLToObjectID(_ url: URL) -> NSManagedObjectID? {
        persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url)
    }
    
    private init() {
        containerName = "HerculesModel"
        persistentContainer = NSPersistentContainer(name: containerName)
        
        persistentContainer.loadPersistentStores { description, error in
            
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

