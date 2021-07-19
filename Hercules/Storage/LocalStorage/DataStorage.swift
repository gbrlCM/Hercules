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
    
    let persistentContainer: NSPersistentContainer
    private let containerName: String
    
    public init() {
        containerName = "HerculesModel"
        persistentContainer = NSPersistentContainer(name: containerName)
        
        persistentContainer.loadPersistentStores { description, error in
            
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
        
        if !UserDefaults.standard.bool(forKey: "shouldMigrate") {
            UserDefaults.standard.setValue(true, forKey: "shouldMigrate")
            performMigration()
        }
    }
    
    private func performMigration() {
        let backgroundContext = persistentContainer.newBackgroundContext()
        let request: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let tagRequest: NSFetchRequest<ExerciseTags> = ExerciseTags.fetchRequest()
        guard
            let exercises = try? backgroundContext.fetch(request),
            let tags = try? backgroundContext.fetch(tagRequest)
        else {
            
            return
        }
        
        if tags.isEmpty {
            let migration: Migration = TagsMigration()
            migration.performMigration(to: backgroundContext)
        }
        
        if exercises.isEmpty {
            let migration: Migration = ExercisesMigration()
            migration.performMigration(to: backgroundContext)
        }
    }
    
}

