//
//  ExerciseStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
import Combine

protocol ExerciseStorage {
    
    var userExercisesSubject: PassthroughSubject<[Exercise], Never> { get }
    var defaultExercisesSubject: PassthroughSubject<[Exercise], Never> { get }
    var defaultTagsSubjects: PassthroughSubject<[ExerciseTag], Never> { get }
    
    func emitAllExercises()
    func emitUserExercises()
    func emitDefaultExercises()
    func emitDefaultTags()
    func save(exercise: Exercise)
}
