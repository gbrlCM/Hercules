//
//  WorkoutsViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import SwiftUI
import Combine

class WorkoutsViewModel: ObservableObject {
    
    private let storage: WorkoutsStorage
    private var cancellables: Set<AnyCancellable>
    
    @Published
    var workouts: [Workout] = []
    
    @Published
    private var fetchedWorkouts: [Workout] = []
    
    @Published
    var isOnForeground = true
    
    init(dataStorage: WorkoutsStorage) {
        storage = dataStorage
        cancellables = Set<AnyCancellable>()
        initiateBindings()
        storage.emitAllWorkoutSubjects()
    }
    
    private func initiateBindings() {
        storage
            .allWorkoutSubjects
            .assign(to: &$fetchedWorkouts)
        
        Publishers.CombineLatest($isOnForeground, $fetchedWorkouts)
            .filter { (isOnForeground, fetchedWorkouts) in
                isOnForeground
            }
            .map { (isOnForeground, fetchedWorkouts) in
                fetchedWorkouts
            }
            .assign(to: &$workouts)
    }
    
    func dateString(for workout: Workout) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale.autoupdatingCurrent
        let dates = calendar
            .shortWeekdaySymbols
            .enumerated()
            .filter {(index, day) in
                workout.daysOfTheWeek.contains(index+1)
            }.map { (index, day) in
                day
            }
        return dates.joined(separator: " - ")
    }
    
    func deleteWorkout(offset: Int) {
        guard let workout = workouts[safe: offset] else { return }
        storage.deleteWorkout(workout)
    }
}
