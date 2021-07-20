//
//  ADWorkout+Workout.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import CoreData

extension ADWorkout {
    
    func fill(withData data: Workout, context: NSManagedObjectContext) {
        self.daysOfTheWeek = data.daysOfTheWeek
        self.focusArea = Int32(data.focusArea.rawValue)
        self.name = data.name
        self.finalDate = data.finalDate
        
        data.exercises
            .map { exercise -> ADWorkoutExercise in
                let workout = ADWorkoutExercise(context: context)
                workout.fill(withData: exercise, context: context)
                return workout
            }.forEach { exercise in
                self.addToExercises(exercise)
            }
    }
}
