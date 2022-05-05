//
//  ExerciseStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
import Combine

protocol ExerciseStorage {
    
    var userExercisesPublisher: AnyPublisher<[Exercise], Never> { get }
    var defaultExercisesPublisher: AnyPublisher<[Exercise], Never> { get }
    var defaultTagsPublisher: AnyPublisher<[ExerciseTag], Never> { get }
    
    func emitAllExercises()
    func emitUserExercises()
    func emitDefaultExercises()
    func emitDefaultTags()
    func save(exercise: Exercise)
}
