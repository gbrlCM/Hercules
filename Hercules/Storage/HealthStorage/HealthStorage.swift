//
//  HealthStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/10/21.
//

import Combine
import HealthKit

protocol HealthStorage {
    
    var isAvailable: Bool { get }
    var activityRingPublisher: AnyPublisher<[ActivityRingData], Never> { get }
    
    func requestAuthorization(completionHandler: ((Bool) -> Void)?)
    func saveWorkout(startDate: Date, duration: TimeInterval, completionHandler: @escaping (UUID?) -> Void)
    
}
