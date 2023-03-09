//
//  ExerciseCreationViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine
import Habitat

class WorkoutCreationViewModel: ObservableObject {
    enum Destination {
        case exerciseList(ExercisesListModel)
    }
    
    @Dependency(\.workoutsStorage)
    private var dataStorage: WorkoutsStorage
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
    
    let areasOfFocus = ExerciseFocusArea.allCases
    
    @Published
    var destination: Destination? = nil {
        didSet {
            bindDestination()
        }
    }
    
    var dismissCreation: () -> Void = { fatalError("uniplemented") }
    
    var isStillCreating: Bool {
        Self.validateUserDidFinishForm(nameField, createdExercises)
    }
    
    init(workout: Workout, destination: Destination? = nil) {
        self.nameField = workout.name
        self.areaOfFocus = workout.focusArea.rawValue
        self.createdExercises = workout.exercises
        self.endDate = workout.finalDate
        self.savedObjectID = workout.objectID
        self.daysSelected = Day.allCases.map { day in workout.daysOfTheWeek.contains(day.rawValue) ? true : false }
        bindDestination()
    }
    
    init(destination: Destination? = nil) {
        self.nameField = ""
        self.areaOfFocus = 1
        self.createdExercises = [WorkoutExercise()]
        self.endDate = Date()
        self.savedObjectID = nil
        self.daysSelected = Day.allCases.map {_ in false }
        bindDestination()
    }
    
    private func bindDestination() {
        guard let destination else { return }
        
        switch destination {
        case .exerciseList(let exercisesListModel):
            exercisesListModel.save = {[weak self] exercise in
                self?.destination = nil
                self?.createdExercises.append(exercise)
            }
        }
    }
    
    func addExerciseButtonTapped() {
        destination = .exerciseList(ExercisesListModel())
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
        dismissCreation()
    }
    
    func deleteExercise(at index: IndexSet) {
        createdExercises.remove(atOffsets: index)
    }
    
    func moveExercise(fromOffsets startOffset: IndexSet, to endOffset: Int) {
        createdExercises.move(fromOffsets: startOffset, toOffset: endOffset)
    }
}

extension WorkoutCreationViewModel {
    private static func validateUserDidFinishForm(_ s1: String, _ s2: [WorkoutExercise]) -> Bool {
        return s1.isEmpty || s2.isEmpty
    }
}
