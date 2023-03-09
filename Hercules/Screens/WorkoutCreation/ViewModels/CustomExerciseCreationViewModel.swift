//
//  CustomExerciseCreationViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 02/08/21.
//

import Foundation

class CustomExerciseCreationViewModel: ObservableObject {
    
    @Published
    var exerciseName: String
    
    @Published
    var exerciseTags: [ExerciseTag]
    
    var allTags: [ExerciseTag]
    
    var save: (Exercise) -> Void = { _ in fatalError("uninplemented") }
    var dismiss: () -> Void = { fatalError("uninplemented") }
    
    init() {
        allTags = PropertyListDecoder.decode("TagsData", to: [ExerciseTag].self) ?? []
        exerciseTags = []
        exerciseName = ""
    }
    
    func toggleTag(at index: Int) {
        guard index < allTags.count else { return }
        let tag = allTags[index]
        
        let selectedIndex = exerciseTags.firstIndex(of: tag)
        
        if let selectedIndex {
            exerciseTags.remove(at: selectedIndex)
        } else {
            exerciseTags.append(tag)
        }
    }
    
    func isTagSelected(_ tag: ExerciseTag) -> Bool {
        exerciseTags.contains(tag)
    }
    
    func cancelButtonTapped() {
        dismiss()
    }
    
    func saveButtonTapped() {
        save(exercise)
    }
    
    var exercise: Exercise {
        Exercise(name: exerciseName, id: UUID().uuidString, tags: exerciseTags)
    }
}
