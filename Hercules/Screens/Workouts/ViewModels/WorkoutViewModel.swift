//
//  WorkoutViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/07/21.
//

import Foundation
import SwiftUI
import Habitat

class WorkoutViewModel: ObservableObject {
    
    let workout: Workout
    
    @Published
    var isEditing: Bool = false
    @Published
    var isPlayingWorkout: Bool = false
    @Published
    var isShowingDeleteAlert: Bool = false
    
    @Dependency(\.workoutsStorage)
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
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    init() {
        self.workout = Workout()
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
    
    func presentDeleteAlert() {
        isShowingDeleteAlert = true
    }
}
