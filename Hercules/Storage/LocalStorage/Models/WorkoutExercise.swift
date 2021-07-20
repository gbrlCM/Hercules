//
//  WorkoutExercise.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct WorkoutExercise: Hashable {
    
    var exerciseName: String
    var exerciseID: String
    var intesityMetric: IntensityType
    var intesityValue: Double
    var repetitions: Int
    var series: Int
    var restTime: Double
    
    init(entity: ADWorkoutExercise) {
        guard
            let name = entity.exerciseName,
            let id = entity.exerciseId,
            let intesityMetric = IntensityType(rawValue: Int(entity.intesityMetric))
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        self.exerciseName = name
        self.exerciseID = id.uuidString
        self.intesityMetric = intesityMetric
        self.intesityValue = entity.intesityValue
        self.repetitions = Int(entity.repetitions)
        self.series = Int(entity.series)
        self.restTime = entity.restTime
    }
    
    init(exerciseName: String,
                  exerciseID: UUID,
                  intesityMetric: IntensityType,
                  intesityValue: Double,
                  repetitions: Int,
                  series: Int,
                  restTime: Double) {
        self.exerciseName = exerciseName
        self.exerciseID = exerciseID.uuidString
        self.intesityMetric = intesityMetric
        self.intesityValue = intesityValue
        self.repetitions = repetitions
        self.series = series
        self.restTime = restTime
    }
    
    
    init() {
        self.exerciseID = UUID().uuidString
        self.exerciseName = "swing"
        self.intesityMetric = .weight
        self.intesityValue = 60
        self.repetitions = 12
        self.series = 4
        self.restTime = 60
    }
}
