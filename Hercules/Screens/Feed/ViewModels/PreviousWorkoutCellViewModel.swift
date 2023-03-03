//
//  PreviousWorkoutCellViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct PreviousWorkoutCellViewModel: Identifiable {
    
    var id: URL
    var dateOfWorkout: String
    var workoutInfo: String
    var session: WorkoutSession
    
    init() {
        id = URL(filePath: UUID().uuidString)
        dateOfWorkout = "Mon 12 Jul"
        workoutInfo = "Leg - 50min - 350kcal"
        session = WorkoutSession()
    }
    
    init(dateOfWorkout: String, workoutInfo: String, session: WorkoutSession) {
        precondition(session.id != nil)
        self.id = session.id!
        self.dateOfWorkout = dateOfWorkout
        self.workoutInfo = workoutInfo
        self.session = session
    }
}
