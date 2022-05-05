//
//  ExerciseListStorageDummy.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
import Combine
@testable import Hercules

class ExerciseStorageDummy: ExerciseStorage {
    var userExercisesPublisher: AnyPublisher<[Exercise], Never> {
        userExercisesSubject.eraseToAnyPublisher()
    }
    
    var defaultExercisesPublisher: AnyPublisher<[Exercise], Never> {
        defaultExercisesSubject.eraseToAnyPublisher()
    }
    
    var defaultTagsPublisher: AnyPublisher<[ExerciseTag], Never> {
        defaultTagsSubjects.eraseToAnyPublisher()
    }
    
    var defaultTagsSubjects: PassthroughSubject<[ExerciseTag], Never>
    
    var userExercisesSubject: PassthroughSubject<[Exercise], Never>
    
    var defaultExercisesSubject: PassthroughSubject<[Exercise], Never>
    
    var savedExercise: Exercise? = nil
    
    var userExercises: [Exercise]
    var defaultExercises: [Exercise]
    
    init() {
        userExercisesSubject = .init()
        defaultExercisesSubject = .init()
        defaultTagsSubjects = .init()
        userExercises = ExercisesDummy.userDummy
        defaultExercises = ExercisesDummy.defaultDummy
    }
    
    func emitAllExercises() {
        emitUserExercises()
        emitDefaultExercises()
    }
    
    func emitUserExercises() {
        userExercisesSubject.send(userExercises)
    }
    
    func emitDefaultExercises() {
        defaultExercisesSubject.send(defaultExercises)
    }
    
    func emitDefaultTags() {
        defaultTagsSubjects.send(TagDummy.dummies)
    }
    
    
    func save(exercise: Exercise) {
        savedExercise = exercise
    }
    
    
}
