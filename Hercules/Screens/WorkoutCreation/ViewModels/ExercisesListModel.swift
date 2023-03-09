//
//  ExercisesListViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine
import CoreData
import SwiftUI
import Habitat
import SwiftUINavigation

class ExercisesListModel: ObservableObject {
    enum Destination {
        case configureExercise(ExerciseCreationViewModel)
        case createCustomExercise(CustomExerciseCreationViewModel)
    }
    
    @Published
    var tags: [ExerciseTag] = []
    
    @Published
    private var fetchedDefaultExercises: [Exercise] = []
    
    @Published
    private var fetchedUserExercises: [Exercise] = []
    
    @Published
    var shouldNavigateToNextSecion: Bool = true
    
    @Published
    var selectedTags: [ExerciseTag] = []
    
    @Published
    var destination: Destination? = nil {
        didSet {
            bindDestination()
        }
    }
    
    var defaultExercises: [Exercise] {
        exercisesWithTags(for: fetchedDefaultExercises, selectedTags: selectedTags)
    }
    
    var userExercises: [Exercise] {
        exercisesWithTags(for: fetchedUserExercises, selectedTags: selectedTags)
    }
    
    var save: (WorkoutExercise) -> Void = { _ in fatalError("uninplemented") }
    
    @Dependency(\.exerciseStorage)
    private var storage: ExerciseStorage
    
    private var cancellables = Set<AnyCancellable>()
    
    init(destination: Destination? = nil) {
        self.storage = storage
        initiateBindings()
        storage.emitAllExercises()
        storage.emitDefaultTags()
        bindDestination()
    }
    
    private func initiateBindings() {
        storage
            .defaultExercisesSubject
            .map { exercises -> [Exercise] in
                var sortedExercises = exercises
                sortedExercises.sort { $0.name < $1.name }
                return sortedExercises
            }
            .assign(to: \.fetchedDefaultExercises, on: self)
            .store(in: &cancellables)
        
        storage
            .userExercisesSubject
            .map { exercises -> [Exercise] in
                var sortedExercises = exercises
                sortedExercises.sort { $0.name < $1.name }
                return sortedExercises
            }
            .assign(to: \.fetchedUserExercises, on: self)
            .store(in: &cancellables)
        
        storage
            .defaultTagsSubjects
            .assign(to: &$tags)
    }
    
    private func bindDestination() {
        guard let destination else { return }
        
        switch destination {
        case let .configureExercise(model):
            model.dismiss = { [weak self] in self?.destination = nil }
            model.save = { [weak self] exercise in self?.save(exercise) }
        case let .createCustomExercise(model):
            model.dismiss = { [weak self] in self?.destination = nil }
            model.save = { [weak self] exercise in
                self?.storage.save(exercise: exercise)
                self?.destination = nil
            }
        }
    }
    
    func addExerciseButtonTapped() {
        destination = .createCustomExercise(CustomExerciseCreationViewModel())
    }
    
    func exerciseButtonTapped(_ exercise: Exercise) {
        destination = .configureExercise(ExerciseCreationViewModel(exercise: exercise))
    }
    
    func toggleTag(of tag: ExerciseTag) {
        let index = selectedTags.firstIndex(of: tag)
        if index == nil {
            selectedTags.append(tag)
        } else {
            selectedTags.remove(at: index!)
        }
    }
    
    private func exercisesWithTags(for exerciseList: [Exercise], selectedTags: [ExerciseTag]) -> [Exercise] {
        if selectedTags == [] {
            return exerciseList
        }
        
        return exerciseList.filter { exercise in
            let setOfTags = Set(exercise.tags.map(\.name))
            return setOfTags.isSuperset(of: selectedTags.map(\.name))
        }
    }
    
    func colorForTag(named tagName: String) -> Color {
        guard let tag = tags.first(where: { $0.name == tagName })
        else { return Color.red}
        return tag.color
    }
    
}
