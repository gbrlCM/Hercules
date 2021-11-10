//
//  WorkoutStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
import Combine

protocol WorkoutsStorage {
    var allWorkoutSubjects: PassthroughSubject<[Workout], Never> { get }
    func emitAllWorkoutSubjects()
    func saveWorkout(_ workout: Workout)
    func editWorkout(_ workout: Workout)
    func deleteWorkout(_ workout: Workout)
}
