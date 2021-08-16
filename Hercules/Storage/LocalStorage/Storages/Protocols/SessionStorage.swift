//
//  SessionStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
import Combine

protocol SessionStorage {
    
    func saveSession(_ workoutSession: WorkoutSession, workoutID: URL)
}
