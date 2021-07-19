//
//  ExercisesRequests.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import CoreData

extension Exercise {
    
    static var allExercises: NSFetchRequest<Exercise> {
        let request: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Exercise.name, ascending: true)]
        
        return request
    }
}
