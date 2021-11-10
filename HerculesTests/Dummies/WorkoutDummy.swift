//
//  WorkoutDummy.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/08/21.
//

import Foundation
@testable import Hercules

enum WorkoutDummy {
    
    static var dummy: Workout = Workout(name: "Test Workout",
                                        focusArea: .leg,
                                        daysOfTheWeek: [1,3],
                                        exercises: exerciseDummy,
                                        finalDate: Date(timeIntervalSince1970: 3600),
                                        sessions: [],
                                        objectID:  nil)
    
    static var dummyWithID: Workout = Workout(name: "Test Workout",
                                              focusArea: .leg,
                                              daysOfTheWeek: [1,3],
                                              exercises: exerciseDummy,
                                              finalDate: Date(timeIntervalSince1970: 3600),
                                              sessions: [],
                                              objectID:  URL(fileURLWithPath: ""))
    
    private static var exerciseDummy: [WorkoutExercise] = [
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
}
