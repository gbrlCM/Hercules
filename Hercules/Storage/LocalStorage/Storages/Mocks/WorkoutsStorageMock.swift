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
    var lastUpdatedWorkout: Workout? = nil
    var workouts: [Workout]
    
    override init() {
        let exerciseDummy = [
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
        
        let sessions = [
            WorkoutSession(healthStoreID: nil, date: Date(timeIntervalSince1970: 125), totalTime: 3600, restTime: 1000, exerciseTime: 2600, workoutName: "Sessions Test 1", exerciseCount: 4, seriesCount: 12),
            WorkoutSession(healthStoreID: nil, date: Date(timeIntervalSince1970: 250), totalTime: 3600, restTime: 1000, exerciseTime: 2600, workoutName: "Sessions Test 2", exerciseCount: 4, seriesCount: 12),
            WorkoutSession(healthStoreID: nil, date: Date(timeIntervalSince1970: 375), totalTime: 3600, restTime: 1000, exerciseTime: 2600, workoutName: "Sessions Test 3", exerciseCount: 4, seriesCount: 12),
            WorkoutSession(healthStoreID: nil, date: Date(timeIntervalSince1970: 500), totalTime: 3600, restTime: 1000, exerciseTime: 2600, workoutName: "Sessions Test 4", exerciseCount: 4, seriesCount: 12),
        ]
        
        let workout = Workout(name: "Test Workout",
                              focusArea: .leg,
                              daysOfTheWeek: [1,3,4,5,6],
                              exercises: exerciseDummy,
                              finalDate: Date(timeIntervalSince1970: 35000),
                              sessions: sessions,
                              objectID: URL(fileURLWithPath: "w1"))
        
        let workout2 = Workout(name: "Test2 Workout",
                              focusArea: .leg,
                              daysOfTheWeek: [1,3,4,5,6],
                              exercises: exerciseDummy,
                              finalDate: Date(timeIntervalSince1970: 35000),
                              sessions: sessions,
                               objectID: URL(fileURLWithPath: "w2"))
        
        let workout3 = Workout(name: "Test3 Workout",
                              focusArea: .leg,
                              daysOfTheWeek: [1,3,4,5,6],
                              exercises: exerciseDummy,
                              finalDate: Date(timeIntervalSince1970: 35000),
                              sessions: sessions,
                               objectID: URL(fileURLWithPath: "w3"))
        
        let workout4 = Workout(name: "Test4 Workout",
                              focusArea: .leg,
                              daysOfTheWeek: [1,3,4,5,6],
                              exercises: exerciseDummy,
                              finalDate: Date(timeIntervalSince1970: 35000),
                              sessions: sessions,
                               objectID: URL(fileURLWithPath: "w4"))
        
        workouts = [workout, workout2, workout3, workout4]
        super.init()
    }
    
    init(workouts: [Workout]) {
        self.workouts = workouts
    }
    
    func emitAllWorkoutSubjects() {
        allWorkoutSubjects.send(workouts)
    }
    
    func saveWorkout(_ workout: Workout) {
        lastSavedWorkout = workout
    }
    
    func editWorkout(_ workout: Workout) {
        lastUpdatedWorkout = workout
    }
    
    func deleteWorkout(_ workout: Workout) {
        guard let index = workouts.firstIndex(of: workout) else { return }
        workouts.remove(at: index)
        allWorkoutSubjects.send(workouts)
    }
}
