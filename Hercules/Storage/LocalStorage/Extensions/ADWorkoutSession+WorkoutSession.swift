//
//  ADWorkoutSession+WorkoutSession.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 27/07/21.
//

import CoreData

extension ADWorkoutSession {
    
    func fill(withData data: WorkoutSession) {
        self.healthStoreID = data.healthStoreID
        self.date = data.date
        self.totalExerciseTime = data.exerciseTime
        self.totalRestTime = data.restTime
        self.totalTime = data.totalTime
    }
}
