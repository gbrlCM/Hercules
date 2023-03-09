//
//  WorkoutsViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import SwiftUI
import Combine
import Habitat

class WorkoutsViewModel: ObservableObject {
    enum Destination {
        case createWorkout(WorkoutCreationViewModel)
        case workoutDetail(WorkoutViewModel)
    }
    
    @Dependency(\.workoutsStorage)
    private var storage: WorkoutsStorage
    private var cancellables: Set<AnyCancellable>
    
    @Published
    var workouts: [Workout] = []
    
    @Published
    private var fetchedWorkouts: [Workout] = []
    
    @Published
    var isOnForeground = true
    
    @Published
    var destination: Destination? {
        didSet {
            bindDestination()
        }
    }
    
    init(destination: Destination? = nil) {
        self.destination = destination
        self.cancellables = Set<AnyCancellable>()
        self.initiateBindings()
        self.storage.emitAllWorkoutSubjects()
        bindDestination()
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
    
    private func bindDestination() {
        guard let destination else { return }
        
        switch destination {
        case let .createWorkout(model):
            model.dismissCreation = { [weak self] in self?.destination = nil }
        case .workoutDetail(_):
            break
        }
    }
    
    func createWorkoutButtonTapped() {
        destination = .createWorkout(WorkoutCreationViewModel())
    }
    
    func workoutButtonTapped(_ workout: Workout) {
        destination = .workoutDetail(WorkoutViewModel(workout: workout))
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
