//
//  WorkoutStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine
import CoreData

class WorkoutsStorage: NSObject {
    
    private let storage: DataStorage
    private let requestController: NSFetchedResultsController<ADWorkout>
    private let context: NSManagedObjectContext
    
    var allWorkoutSubjects = PassthroughSubject<[Workout], Never>()
    
    override init() {
        self.storage = DataStorage.shared
        self.context = storage.persistentContainer.viewContext
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
            allWorkoutSubjects.send(objects.map { Workout(entity: $0) })
        } catch {
            print("Error Fetching results")
        }
    }
    
    func saveWorkout(_ workout: Workout) {
        let entityWorkout = ADWorkout(context: context)
        entityWorkout.fill(withData: workout, context: context)
        do {
            try context.save()
            print("workout saved")
        } catch(let error) {
            context.rollback()
            print("error saving \(error)")
        }
    }
    
    var allWorkouts: NSFetchRequest<ADWorkout> = {
        let request: NSFetchRequest<ADWorkout> = ADWorkout.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADWorkout.name, ascending: true)]
        return request
    }()
}

extension WorkoutsStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let data = controller.fetchedObjects as? [ADWorkout] else { return }
        
        allWorkoutSubjects.send(data.map { Workout(entity: $0) })
    }
}
