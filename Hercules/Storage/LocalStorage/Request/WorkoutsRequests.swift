//
//  WorkoutsRequests.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import CoreData

extension ADWorkout {
    
    static var allWorkouts: NSFetchRequest<ADWorkout> {
        let request: NSFetchRequest<ADWorkout> = ADWorkout.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADWorkout.name, ascending: true)]
        
        return request
    }
}
