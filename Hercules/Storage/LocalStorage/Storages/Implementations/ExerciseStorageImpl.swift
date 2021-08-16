//
//  ExerciseStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation
import CoreData
import Combine

class ExerciseStorageImpl: NSObject, ExerciseStorage {
 
    private let context: NSManagedObjectContext
    
    var userExercisesSubject = PassthroughSubject<[Exercise], Never>()
    var defaultExercisesSubject = PassthroughSubject<[Exercise], Never>()
    var defaultTagsSubjects = PassthroughSubject<[ExerciseTag], Never>()
    private var fetchedResultController: NSFetchedResultsController<ADExercise>
    
    override init() {
        self.context = DataStorage.shared.context
        let request: NSFetchRequest<ADExercise> = ADExercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADExercise.name, ascending: true)]
        fetchedResultController = NSFetchedResultsController<ADExercise>(fetchRequest: request,
                                                                         managedObjectContext: context,
                                                                         sectionNameKeyPath: nil,
                                                                         cacheName: nil)
        super.init()
    }
    
    func emitAllExercises() {
        emitUserExercises()
        emitDefaultExercises()
    }
    
    func emitUserExercises() {

        do {
            try fetchedResultController.performFetch()
            guard let objects = fetchedResultController.fetchedObjects else { return }
            userExercisesSubject.send(objects.map { Exercise(entity: $0) })
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
    
    func emitDefaultTags() {
        guard let tags = PropertyListDecoder.decode("TagsData", to: [ExerciseTag].self)
        else {
            defaultTagsSubjects.send([])
            return
        }
        
        defaultTagsSubjects.send(tags)
    }
    
    func save(exercise: Exercise) {
        
        let entity = ADExercise(context: context)
        entity.name = exercise.name
        entity.standardTags = exercise.tags.map(\.name)
        entity.id = UUID(uuidString: exercise.id)
        
        context.safeSave()
    }
    
}

extension ExerciseStorageImpl: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let data = controller.fetchedObjects as? [ADExercise] else { return }
        
        do {
            try context.obtainPermanentIDs(for: data)
        } catch(let error) {
            print(error)
        }
        
        userExercisesSubject.send(data.compactMap { Exercise(entity: $0) })
    }
}
