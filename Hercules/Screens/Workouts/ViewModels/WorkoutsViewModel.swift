//
//  WorkoutsViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import Combine

class WorkoutsViewModel: ObservableObject {
    
    private let storage: WorkoutsStorage
    private var cancellables: Set<AnyCancellable>
    
    @Published
    var workouts: [Workout] = []
    
    init() {
        storage = WorkoutsStorage()
        cancellables = Set<AnyCancellable>()
        initiateBindings()
        storage.emitAllWorkoutSubjects()
    }
    
    private func initiateBindings() {
        storage
            .allWorkoutSubjects
            .assign(to: \.workouts, on: self)
            .store(in: &cancellables)
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
}
