//
//  WorkoutStorageImpl.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/10/21.
//

import Foundation
import Combine

final class WorkoutsStorageMock: NSObject, WorkoutsStorage {
    
    var allWorkoutSubjects: PassthroughSubject<[Workout], Never> = .init()
    
    var lastSavedWorkout: Workout? = nil
    
    func emitAllWorkoutSubjects() {
        
    let exerciseDummy: [WorkoutExercise] = [
        WorkoutExercise(exerciseName: "Wall Ball",
                        exerciseID: UUID(),
                        intesityMetric: .weight,
                        intesityValue: 45,
                        repetitions: 12,
                        series: 3,
                        restTime: 60),
        WorkoutExercise(exerciseName: "Leg Press",
                        exerciseID: UUID(),
                        intesityMetric: .weight,
                        intesityValue: 90,
                        repetitions: 8,
                        series: 4,
                        restTime: 75),
        WorkoutExercise(exerciseName: "Bench Press",
                        exerciseID: UUID(),
                        intesityMetric: .areaOfRm,
                        intesityValue: 12,
                        repetitions: 12,
                        series: 3,
                        restTime: 90)
        
    ]
        
        let workout = Workout(name: "Test Workout",
                focusArea: .leg,
                daysOfTheWeek: [1,3],
                exercises: exerciseDummy,
                finalDate: Date(),
                sessions: [])
        
        allWorkoutSubjects.send([workout, workout, workout, workout])
    }
    
    func saveWorkout(_ workout: Workout) {
        lastSavedWorkout = workout
    }
    
    func editWorkout(withID url: URL, _ workout: Workout) {
        lastSavedWorkout = workout
    }
    
    
}
