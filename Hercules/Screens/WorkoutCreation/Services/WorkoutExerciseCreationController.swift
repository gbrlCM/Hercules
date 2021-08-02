//
//  WorkoutExerciseCreationController.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import Foundation
import Combine

class WorkoutExerciseCreationController: ObservableObject {
    
    var createdExercise = PassthroughSubject<WorkoutExercise, Never>()
    
    func emit(exercise: WorkoutExercise) {
        createdExercise.send(exercise)
    }
}
