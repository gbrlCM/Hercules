//
//  ADWorkoutExercise+WorkoutExercise.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import CoreData

extension ADWorkoutExercise {
    
    func fill(withData data: WorkoutExercise, context: NSManagedObjectContext) {
        self.exerciseId = UUID(uuidString: data.exerciseID)
        self.exerciseName = data.exerciseName
        self.intesityMetric = Int32(data.intesityMetric.rawValue)
        self.intesityValue = data.intesityValue
        self.repetitions = Int32(data.repetitions)
        self.restTime = data.restTime
        self.series = Int32(data.series)
    }
}
