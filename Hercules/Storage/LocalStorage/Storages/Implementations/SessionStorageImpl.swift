//
//  SessionStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 27/07/21.
//

import CoreData

class SessionStorageImpl: SessionStorage {
    
    private let dataStorage: DataStorage
    private let context: NSManagedObjectContext
    
    init(dataStorage: DataStorage = DataStorage.shared) {
        self.dataStorage = dataStorage
        self.context = dataStorage.context
    }
    
    func saveSession(_ workoutSession: WorkoutSession, workoutID: URL) {
        let entitySession = ADWorkoutSession(context: context)
        entitySession.fill(withData: workoutSession)
        
        guard
            let id = dataStorage.convertURLToObjectID(workoutID),
            let entityWorkout = context.object(with: id) as? ADWorkout
        else {
            return
        }
        entityWorkout.addToSessions(entitySession)
        context.safeSave()
    }
}
