//
//  ExerciseCreationViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine

class WorkoutCreationViewModel: ObservableObject {
    
    private let dataStorage: WorkoutsStorage
    private var cancellables = Set<AnyCancellable>()
    private let savedObjectID: URL?
    
    @Published
    var daysSelected: [Bool]
    @Published
    var nameField: String
    @Published
    var areaOfFocus: Int
    @Published
    var createdExercises: [WorkoutExercise]
    @Published
    var endDate: Date
    
    @Published
    var creatingNewItem: Bool = false
    
    var exerciseCreationController = WorkoutExerciseCreationController()
    let areasOfFocus = ExerciseFocusArea.allCases
    
    @Published
    var isStillCreating: Bool = true
    
    var dismissCreation: () -> Void = { fatalError("uniplemented") }
    
    private var isStillCreatingPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($nameField, $createdExercises)
            .map(validateUserDidFinishForm)
            .eraseToAnyPublisher()
    }
    
    init(workout: Workout, storage: WorkoutsStorage = WorkoutsStorageImpl()) {
        self.nameField = workout.name
        self.areaOfFocus = workout.focusArea.rawValue
        self.createdExercises = workout.exercises
        self.endDate = workout.finalDate
        self.savedObjectID = workout.objectID
        self.daysSelected = Day.allCases.map { day in workout.daysOfTheWeek.contains(day.rawValue) ? true : false }
        self.dataStorage = storage
        initiateBindings()
    }
    
    init(storage: WorkoutsStorage = WorkoutsStorageImpl()) {
        self.nameField = ""
        self.areaOfFocus = 1
        self.createdExercises = []
        self.endDate = Date()
        self.savedObjectID = nil
        self.daysSelected = Day.allCases.map {_ in false }
        self.dataStorage = storage
        initiateBindings()
    }
    
    private func validateUserDidFinishForm(_ s1: String, _ s2: [WorkoutExercise]) -> Bool {
        return s1.isEmpty || s2.isEmpty
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
                              finalDate: endDate,
                              sessions: [],
                              objectID: savedObjectID)
        
        
        if savedObjectID != nil {
            dataStorage.editWorkout(workout)
        } else {
            dataStorage.saveWorkout(workout)
        }
    }
}
