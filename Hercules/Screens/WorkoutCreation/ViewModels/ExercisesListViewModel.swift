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

class ExercisesListViewModel: NSObject, ObservableObject {
    
    @Published
    var tags: [ExerciseTag] = []
    
    @Published
    var defaultExercises: [Exercise] = []
    
    @Published
    var userExercises: [Exercise] = []
    
    @Published
    private var fetchedDefaultExercises: [Exercise] = []
    
    @Published
    var shouldNavigateToNextSecion: Bool = true
    
    @Published
    var selectedTags: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var storage = ExerciseStorage()
    
    override init() {
        super.init()
        initiateBindings()
        storage.emitAllExercises()
        tags = PropertyListDecoder.decode("TagsData", to: [ExerciseTag].self) ?? []
    }
    
    private func initiateBindings() {
        storage
            .defaultExercisesSubject
            .map { exercises -> [Exercise] in
                var sortedExercises = exercises
                sortedExercises.sort { $0.name < $1.name}
                print("ooi")
                return sortedExercises
            }
            .assign(to: \.fetchedDefaultExercises, on: self)
            .store(in: &cancellables)
        
        storage
            .userExercisesSubject
            .map { exercises -> [Exercise] in
                var sortedExercises = exercises
                sortedExercises.sort { $0.name < $1.name}
                return sortedExercises
            }
            .assign(to: \.userExercises, on: self)
            .store(in: &cancellables)
        
        $fetchedDefaultExercises
            .sink {[weak self] exercises in
                self?.defaultExercises = self?.updateExercisesWithTags(for: exercises) ?? []
            }
            .store(in: &cancellables)
    }
    
    func toggleTag(of tag: ExerciseTag) {
        let name = tag.name
        let index = selectedTags.firstIndex(of: name)
        if index == nil {
            selectedTags.append(name)
        } else {
            selectedTags.remove(at: index!)
        }
        userExercises = updateExercisesWithTags(for: userExercises)
        defaultExercises = updateExercisesWithTags(for: fetchedDefaultExercises)
        print(selectedTags)
    }
    
    private func updateExercisesWithTags(for exerciseList: [Exercise]) -> [Exercise] {
        if selectedTags == [] {
            return exerciseList
        } else {
            return exerciseList.filter { exercise in
                let setOfTags = Set(exercise.tags)
                return setOfTags.isSuperset(of: selectedTags)
            }
        }
    }
    
    func colorForTag(named tagName: String) -> Color {
        guard let tag = tags.first(where: { $0.name == tagName })
        else { return Color.red}
        return tag.color
    }
    
}
