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
    
    init() {
        allTags = PropertyListDecoder.decode("TagsData", to: [ExerciseTag].self) ?? []
        exerciseTags = []
        exerciseName = ""
    }
    
    func toggleTag(of tag: ExerciseTag) {
        let index = exerciseTags.firstIndex(of: tag)
        if index == nil {
            exerciseTags.append(tag)
        } else {
            exerciseTags.remove(at: index!)
        }
    }
    
    var exercise: Exercise {
        Exercise(name: exerciseName, id: UUID().uuidString, tags: exerciseTags)
    }
}
