//
//  PreviousWorkoutCellViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct PreviousWorkoutCellViewModel: Identifiable {
    
    var id = UUID()
    var dateOfWorkout: String
    var workoutInfo: String
    
    init() {
        dateOfWorkout = "Mon 12 Jul"
        workoutInfo = "Leg - 50min - 350kcal"
    }
    
    init(dateOfWorkout: String, workoutInfo: String) {
        self.dateOfWorkout = dateOfWorkout
        self.workoutInfo = workoutInfo
    }
}
