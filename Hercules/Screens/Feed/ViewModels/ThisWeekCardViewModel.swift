//
//  ThisWeekCardViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

class ThisWeekCardViewModel: ObservableObject, Identifiable {
    
    var id: URL { workout.objectID! }
    let exerciseName: String
    let exerciseDate: String
    var workout: Workout
    
    init() {
        exerciseName = "Leg - 8 exercises"
        exerciseDate = "Today"
        workout = Workout()
    }
    
    init(name: String, dateString: String, workout: Workout) {
        exerciseName = name
        exerciseDate = dateString
        self.workout = workout
    }
    
}
