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

class ExercisesListViewModel:ObservableObject {
    
    @Published
    var tags: [ExerciseTag] = []
    
    @Published
    var defaultExercises: [Exercise] = []
    
    @Published
    var userExercises: [Exercise] = []
    
    @Published
    private var fetchedDefaultExercises: [Exercise] = []
    
    @Published
    private var fetchedUserExercises: [Exercise] = []
    
    @Published
    var shouldNavigateToNextSecion: Bool = true
    
    @Published
    var selectedTags: [ExerciseTag] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var storage: ExerciseStorage
    
    init(storage: ExerciseStorage) {
        self.storage = storage
        initiateBindings()
        storage.emitAllExercises()
        storage.emitDefaultTags()
    }
    
    private func initiateBindings() {
        storage
            .defaultExercisesPublisher
            .map { exercises -> [Exercise] in
                var sortedExercises = exercises
                sortedExercises.sort { $0.name < $1.name}
                return sortedExercises
            }
            .assign(to: \.fetchedDefaultExercises, on: self)
            .store(in: &cancellables)
        
        storage
            .userExercisesPublisher
            .map { exercises -> [Exercise] in
                var sortedExercises = exercises
                sortedExercises.sort { $0.name < $1.name}
                return sortedExercises
            }
            .assign(to: &$fetchedUserExercises)
        
        $fetchedDefaultExercises
            .map(updateExercisesWithTags)
            .assign(to: &$defaultExercises)
        
        $fetchedUserExercises
            .map(updateExercisesWithTags)
            .assign(to: &$userExercises)
        
        storage
            .defaultTagsPublisher
            .assign(to: &$tags)
    }
    
    func toggleTag(of tag: ExerciseTag) {
        let index = selectedTags.firstIndex(of: tag)
        if index == nil {
            selectedTags.append(tag)
        } else {
            selectedTags.remove(at: index!)
        }
        userExercises = updateExercisesWithTags(for: fetchedUserExercises)
        defaultExercises = updateExercisesWithTags(for: fetchedDefaultExercises)
    }
    
    private func updateExercisesWithTags(for exerciseList: [Exercise]) -> [Exercise] {
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
