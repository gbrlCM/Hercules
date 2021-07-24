//
//  ExerciseStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation
import CoreData
import Combine

class ExerciseStorage {
    
    private let context: NSManagedObjectContext
    
    var userExercisesSubject = PassthroughSubject<[Exercise], Never>()
    var defaultExercisesSubject = PassthroughSubject<[Exercise], Never>()
    
    init() {
        self.context = DataStorage.shared.context
    }
    
    func emitAllExercises() {
        emitUserExercises()
        emitDefaultExercises()
    }
    
    func emitUserExercises() {
        
        let request: NSFetchRequest<ADExercise> = ADExercise.fetchRequest()

        do {
            let entities = try context.fetch(request)
            userExercisesSubject.send(entities.map { Exercise(entity: $0) })
        } catch {
            userExercisesSubject.send([])
        }
    }
    
    func emitDefaultExercises() {
        guard let list = PropertyListDecoder.decode("ExercisesData", to: [Exercise].self)
        else {
            defaultExercisesSubject.send([])
            return
        }
        defaultExercisesSubject.send(list)
        
    }
    
    func save(exercise: Exercise) throws {
        
        let entity = ADExercise(context: context)
        
        entity.name = exercise.name
        entity.id = UUID(uuidString: exercise.id)
    }
    
}
