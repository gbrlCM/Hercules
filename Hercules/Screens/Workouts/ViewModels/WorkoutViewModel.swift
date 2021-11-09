//
//  WorkoutViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/07/21.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    
    @Binding
    var workout: Workout
    
    @Published
    var isEditing: Bool = false
    @Published
    var isPlayingWorkout: Bool = false
    
    private var storage: WorkoutsStorage
    
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
    
    init(workout: Binding<Workout>, storage: WorkoutsStorage = WorkoutsStorageImpl()) {
        self._workout = workout
        self.storage = storage
    }
    
    init() {
        self._workout = .constant(Workout())
        self.storage = WorkoutsStorageImpl()
    }
    
    func startEditing() {
        isEditing = true
    }
    
    func startWorkout() {
        isPlayingWorkout = true
    }
    
    func deleteWorkout() {
        storage.deleteWorkout(workout)
    }
}
