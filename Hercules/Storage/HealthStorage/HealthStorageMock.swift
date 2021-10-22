//
//  HealthStorageMock.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/10/21.
//

import Combine
import Foundation

final class HealthStorageMock: HealthStorage {
    
    var isAvailable: Bool { true }
    
    var activityRingPublisher: AnyPublisher<[ActivityRingData], Never> {
        Just([ActivityRingData(name: .calories, achieved: 400, goal: 450), ActivityRingData(name: .move, achieved: 55, goal: 60), ActivityRingData(name: .stand, achieved: 12, goal: 12)])
            .eraseToAnyPublisher()
    }
    
    func requestAuthorization(completionHandler: ((Bool) -> Void)?) {
        guard let completionHandler = completionHandler else {
            return
        }
        
        completionHandler(true)
    }
    
    func saveWorkout(startDate: Date, duration: TimeInterval, completionHandler: @escaping (UUID?) -> Void) {
        completionHandler(UUID())
    }
    
    
}
