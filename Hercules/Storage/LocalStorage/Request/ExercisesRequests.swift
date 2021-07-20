//
//  ExercisesRequests.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import CoreData

extension Exercise {
    
    static var allExercises: NSFetchRequest<ADExercise> {
        let request: NSFetchRequest<ADExercise> = ADExercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADExercise.name, ascending: true)]
        
        return request
    }
}
