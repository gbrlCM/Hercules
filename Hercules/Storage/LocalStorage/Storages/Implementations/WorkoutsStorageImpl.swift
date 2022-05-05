//
//  WorkoutStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine
import CoreData

class WorkoutsStorageImpl: NSObject, WorkoutsStorage {
    private let dataStorage: DataStorage
    private let requestController: NSFetchedResultsController<ADWorkout>
    private let context: NSManagedObjectContext
    
    var allWorkoutsPublisher: AnyPublisher<[Workout], Never> {
        allWorkoutSubjects.eraseToAnyPublisher()
    }
    
    private var allWorkoutSubjects = PassthroughSubject<[Workout], Never>()
    
    init(dataStorage: DataStorage = DataStorage.shared) {
        self.dataStorage = dataStorage
        self.context = dataStorage.context
        self.requestController = NSFetchedResultsController(fetchRequest: allWorkouts,
                                                            managedObjectContext: context,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)
        super.init()
        requestController.delegate = self
    }
    
    func emitAllWorkoutSubjects() {
        do {
            try requestController.performFetch()
            guard let objects = requestController.fetchedObjects else { return }
            allWorkoutSubjects.send(objects.compactMap { Workout(entity: $0) })
        } catch {
            print("Error Fetching results")
        }
    }
    
    func saveWorkout(_ workout: Workout) {
        let entityWorkout = ADWorkout(context: context)
        entityWorkout.fill(withData: workout, context: context)
        context.safeSave()
    }
    
    func editWorkout(_ workout: Workout) {
        guard
            let url = workout.objectID,
            let id = dataStorage.convertURLToObjectID(url),
            let entity = context.object(with: id) as? ADWorkout,
            let entityExercises = entity.exercises?.array as? [ADWorkoutExercise]
        else {
            return
        }
        let exercises = entityExercises.map { WorkoutExercise(entity: $0) }
        
        if !exercises.elementsEqual(workout.exercises) {
            entityExercises.forEach { exercise in
                context.delete(exercise)
            }
            entity.fill(withData: workout, context: context)
        } else {
            entity.daysOfTheWeek = workout.daysOfTheWeek
            entity.focusArea = Int32(workout.focusArea.rawValue)
            entity.name = workout.name
            entity.finalDate = workout.finalDate
        }
        context.safeSave()
    }
    
    func deleteWorkout(_ workout: Workout) {
        guard
            let url = workout.objectID,
            let id = dataStorage.convertURLToObjectID(url)
        else { return }
        
        let entity = context.object(with: id)
        
        context.delete(entity)
        context.safeSave()
    }
    
    private var allWorkouts: NSFetchRequest<ADWorkout> = {
        let request: NSFetchRequest<ADWorkout> = ADWorkout.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADWorkout.name, ascending: true)]
        return request
    }()
}

extension WorkoutsStorageImpl: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let data = controller.fetchedObjects as? [ADWorkout] else { return }
        
        do {
            try context.obtainPermanentIDs(for: data)
        } catch(let error) {
            print(error)
        }
        
        allWorkoutSubjects.send(data.compactMap { Workout(entity: $0) })
    }
    
}
