//
//  Workout.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct Workout: Hashable {
    var focusArea: ExerciseFocusArea
    var exercises: [WorkoutExercise]
    var sessions: [WorkoutSession]
    var name: String
    var daysOfTheWeek: [Int]
    var finalDate: Date
    var objectID: URL?
    
    
    init?(entity: ADWorkout) {
        
        guard
            let name = entity.name,
            let daysOfTheWeek = entity.daysOfTheWeek,
            let focusArea = ExerciseFocusArea(rawValue: Int(entity.focusArea)),
            let exercises = entity.exercises?.array as? [ADWorkoutExercise],
            let sessions = entity.sessions?.allObjects as? [ADWorkoutSession],
            let finalDate = entity.finalDate
        else {
            return nil
        }
        self.name = name
        self.focusArea = focusArea
        self.daysOfTheWeek = daysOfTheWeek
        self.exercises = exercises.map { WorkoutExercise(entity: $0) }
        self.sessions = sessions.map { WorkoutSession(entity: $0) }
        self.finalDate = finalDate
        self.objectID = entity.objectID.uriRepresentation()
    }
    
    init(name: String, focusArea: ExerciseFocusArea, daysOfTheWeek: [Int], exercises: [WorkoutExercise], finalDate: Date, sessions: [WorkoutSession]) {
        self.name = name
        self.focusArea = focusArea
        self.daysOfTheWeek = daysOfTheWeek
        self.exercises = exercises
        self.finalDate = finalDate
        self.objectID = nil
        self.sessions = sessions
    }
    
    init() {
        self.name = "Leg day"
        self.focusArea = .leg
        self.daysOfTheWeek = [1, 3, 5]
        self.exercises = Array(repeating: WorkoutExercise(), count: 6)
        self.finalDate = Date()
        self.objectID = nil
        self.sessions = Array(repeating: WorkoutSession(), count: 4)
    }
}
