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
    
    private static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: DataStorage.self)
        let containerName = "HerculesModel"
        guard let url = bundle.url(forResource: containerName, withExtension: "momd") else {
          fatalError("Failed to locate momd file")
        }

        guard let model = NSManagedObjectModel(contentsOf: url) else {
          fatalError("Failed to load momd file")
        }

        return model
      }()
    
    private let persistentContainer: NSPersistentContainer
    private let containerName: String
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func convertURLToObjectID(_ url: URL) -> NSManagedObjectID? {
        persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url)
    }
    
    init(_ storeType: StoreType = .persisted) {
        containerName = "HerculesModel"
        persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: Self.managedObjectModel)
        
        if storeType == .inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { description, error in
            
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

enum StoreType {
    case persisted, inMemory
}

