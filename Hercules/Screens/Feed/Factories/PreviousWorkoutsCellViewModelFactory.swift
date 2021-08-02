//
//  PreviousWorkoutsCellViewModelFactory.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 28/07/21.
//

import Foundation

struct PreviousWorkoutsCellViewModelFactory {
    
    static func build(workoutSession: WorkoutSession) -> PreviousWorkoutCellViewModel {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        let formatter = DateComponentsFormatter()
        
        var calendar = Calendar.current
        calendar.locale = .autoupdatingCurrent
        
        let title = dateFormatter.string(from: workoutSession.date) 
        
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .brief
        
        let totalTime = formatter.string(from: workoutSession.totalTime) ?? " "
        
        let subtitle = "\(workoutSession.workoutName) - \(totalTime)"
        
        return PreviousWorkoutCellViewModel(dateOfWorkout: title, workoutInfo: subtitle, session: workoutSession)
    }
}
