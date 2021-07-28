//
//  WorkoutSession.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct WorkoutSession: Hashable {
    
    let healthStoreID: String?
    let workoutName: String
    let date: Date
    let totalTime: TimeInterval
    let restTime: TimeInterval
    let exerciseTime: TimeInterval
    
    init(entity: ADWorkoutSession) {
        
        guard
            let date = entity.date,
            let workoutName = entity.workout?.name
        
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        self.date = date
        self.totalTime = entity.totalTime
        self.restTime = entity.totalRestTime
        self.exerciseTime = entity.totalExerciseTime
        self.healthStoreID = entity.healthStoreID
        self.workoutName = workoutName
    }
    
    init(healthStoreID: String?, date: Date, totalTime: TimeInterval, restTime: TimeInterval, exerciseTime: TimeInterval, workoutName: String) {
        self.healthStoreID = healthStoreID
        self.date = date
        self.totalTime = totalTime
        self.restTime = restTime
        self.exerciseTime = exerciseTime
        self.workoutName = workoutName
    }
    
    init() {
        self.healthStoreID = nil
        self.date = Date()
        self.totalTime = 3000
        self.exerciseTime = 2500
        self.restTime = 500
        self.workoutName = "Leg Day"
    }
}
