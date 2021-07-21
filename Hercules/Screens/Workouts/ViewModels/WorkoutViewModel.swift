//
//  WorkoutViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/07/21.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    
    @Published
    var workout: Workout
    
    var days:[String] = {
        var calendar = Calendar.current
        calendar.locale = Locale.autoupdatingCurrent
        return calendar.veryShortWeekdaySymbols
    }()
    
    var endDateFormatted: String {
        let date = workout.finalDate
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .short
        formatter.calendar = Calendar.current
        
        return formatter.string(from: date)
    }
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    init() {
        self.workout = Workout()
    }
}
