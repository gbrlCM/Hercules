//
//  WorkoutStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import CoreData

class WorkoutsStorage {
    
    private let storage: DataStorage
    let context: NSManagedObjectContext
    
    
    init() {
        self.storage = DataStorage.shared
        self.context = storage.persistentContainer.viewContext
    }
    
    var allWorkouts: NSFetchRequest<Workout> = {
        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Workout.name, ascending: true)]
        return request
    }()
}
