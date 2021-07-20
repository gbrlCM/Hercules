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
    
    var allWorkouts: NSFetchRequest<ADWorkout> = {
        let request: NSFetchRequest<ADWorkout> = ADWorkout.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADWorkout.name, ascending: true)]
        return request
    }()
}
