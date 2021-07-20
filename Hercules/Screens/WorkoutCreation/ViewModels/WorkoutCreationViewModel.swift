//
//  ExerciseCreationViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine

class WorkoutCreationViewModel: ObservableObject {
    
    private let dataStorage = WorkoutsStorage()
    private var cancellables = Set<AnyCancellable>()
    
    @Published
    var daysSelected: [Bool] = Day.allCases.map {_ in false }
    @Published
    var nameField: String = ""
    @Published
    var areaOfFocus: Int = 0
    @Published
    var createdExercises: [WorkoutExercise] = []
    @Published
    var creatingNewItem: Bool = false
    @Published
    var endDate: Date = Date()
    var exerciseCreationController = WorkoutExerciseCreationController()
    let areasOfFocus = ExerciseFocusArea.allCases
    
    @Published
    var isStillCreating: Bool = true
    
    private var isStillCreatingPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($nameField,$createdExercises, $endDate)
            .map {(nameField, createdExercises, endDate) -> Bool in
                guard
                    !nameField.isEmpty,
                    !createdExercises.isEmpty
                else {
                    print("true")
                    return true
                }
                print("false")
                return false
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        initiateBindings()
    }
    
    private func initiateBindings() {
        exerciseCreationController
            .createdExercise
            .sink { [weak self] exercise in
                self?.createdExercises.append(exercise)
            }
            .store(in: &cancellables)
        
        isStillCreatingPublisher
            .assign(to: \.isStillCreating, on: self)
            .store(in: &cancellables)
    }
    
    func saveWorkout() {
        guard let focusArea = ExerciseFocusArea(rawValue: areaOfFocus) else {
            preconditionFailure("Error implementing Picker, Review imediatly")
        }
        
        let days = Day.allCases
            .enumerated()
            .filter { index, day in
                return daysSelected[index]
            }
            .map { index , day in day.rawValue}
        
        let workout = Workout(name: nameField,
                              focusArea: focusArea,
                              daysOfTheWeek: days,
                              exercises: createdExercises,
                              finalDate: endDate)
        
        dataStorage.saveWorkout(workout)
    }
}
