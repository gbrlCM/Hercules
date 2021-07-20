//
//  Workout.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct Workout {
    var focusArea: ExerciseFocusArea
    var name: String
    var daysOfTheWeek: [Int]
    
    init(entity: ADWorkout) {
        
        guard
            let name = entity.name,
            let daysOfTheWeek = entity.daysOfTheWeek,
            let focusArea = ExerciseFocusArea(rawValue: Int(entity.focusArea))
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        self.name = name
        self.focusArea = focusArea
        self.daysOfTheWeek = daysOfTheWeek
    }
    
    init(name: String, focusArea: ExerciseFocusArea, daysOfTheWeek: [Int]) {
        self.name = name
        self.focusArea = focusArea
        self.daysOfTheWeek = daysOfTheWeek
    }
    
    init() {
        self.name = "Leg day"
        self.focusArea = .leg
        self.daysOfTheWeek = [1, 3, 5]
    }
}
