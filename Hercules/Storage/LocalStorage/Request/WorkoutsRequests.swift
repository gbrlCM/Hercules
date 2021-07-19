//
//  WorkoutsRequests.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import CoreData

extension Workout {
    
    static var allWorkouts: NSFetchRequest<Workout> {
        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Workout.name, ascending: true)]
        
        return request
    }
}
