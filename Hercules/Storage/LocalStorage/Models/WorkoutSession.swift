//
//  WorkoutSession.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct WorkoutSession {
    
    let healthStoreID: String?
    let date: Date
    
    init(entity: ADWorkoutSession) {
        
        guard let date = entity.date
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        self.date = date
        self.healthStoreID = entity.healthStoreID
    }
    
    init(healthStoreID: String?, date: Date) {
        self.healthStoreID = healthStoreID
        self.date = date
    }
    
    init() {
        self.healthStoreID = nil
        self.date = Date()
    }
}
