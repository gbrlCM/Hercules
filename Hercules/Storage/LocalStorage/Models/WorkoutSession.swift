//
//  WorkoutSession.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct WorkoutSession: Hashable, Identifiable {
    
    var id: URL?
    let healthStoreID: String?
    let workoutName: String
    let date: Date
    let totalTime: TimeInterval
    let restTime: TimeInterval
    let exerciseTime: TimeInterval
    let exerciseCount: Int
    let seriesCount: Int
    
    init(entity: ADWorkoutSession) {
        
        guard
            let date = entity.date,
            let workoutName = entity.workout?.name,
            let exercises = entity.workout?.exercises?.array as? [ADWorkoutExercise]
        
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        self.id = entity.objectID.uriRepresentation()
        self.date = date
        self.totalTime = entity.totalTime
        self.restTime = entity.totalRestTime
        self.exerciseTime = entity.totalExerciseTime
        self.healthStoreID = entity.healthStoreID
        self.workoutName = workoutName
        self.exerciseCount = exercises.count
        self.seriesCount = exercises.compactMap { Int($0.series) }.reduce(0, +)
    }
    
    init(healthStoreID: String?, date: Date, totalTime: TimeInterval, restTime: TimeInterval, exerciseTime: TimeInterval, workoutName: String, exerciseCount: Int, seriesCount: Int) {
        self.healthStoreID = healthStoreID
        self.date = date
        self.totalTime = totalTime
        self.restTime = restTime
        self.exerciseTime = exerciseTime
        self.workoutName = workoutName
        self.exerciseCount = exerciseCount
        self.seriesCount = seriesCount
    }
    
    init() {
        self.healthStoreID = nil
        self.date = Date()
        self.totalTime = 3000
        self.exerciseTime = 2500
        self.restTime = 500
        self.workoutName = "Leg Day"
        self.exerciseCount = 4
        self.seriesCount = 36
    }
}
