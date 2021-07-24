//
//  HealthStorage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 23/07/21.
//

import Foundation
import HealthKit
import Combine

class HealthStorage {
    
    private let storage: HKHealthStore
    var isAvailable: Bool { HKHealthStore.isHealthDataAvailable() }
    
    private(set) var activityRingPublisher = PassthroughSubject<[ActivityRingData], Never>()
    
    init() {
        storage = HKHealthStore()
    }
    
    func requestAuthorization() {
        
        let writeTypes: Set = [
            HKQuantityType.workoutType(),
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        ]
        
        let readTypes: Set = [
            HKQuantityType.workoutType(),
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.activitySummaryType()
        ]
        
        storage.requestAuthorization(toShare: writeTypes, read: readTypes ) {[weak self] success, error in
            if success {
                print(success)
                self?.requestActivityRingData()
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func requestActivityRingData() {
        let calendar = Calendar.autoupdatingCurrent
        var dateComponents = calendar.dateComponents( [ .year, .month, .day ],
                                                      from: Date())
        dateComponents.calendar = calendar
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        
        let query = HKActivitySummaryQuery(predicate: predicate) {[weak self] query, data, error in
            
            guard let summaries = data,
                  !summaries.isEmpty,
                  let summary = summaries.first
            else {
                print(error ?? "")
                return
            }
            let energyUnit = HKUnit.kilocalorie()
            let standUnit = HKUnit.count()
            let exerciseUnit = HKUnit.minute()
            
            let energy = summary.activeEnergyBurned.doubleValue(for: energyUnit)
            let stand = summary.appleStandHours.doubleValue(for: standUnit)
            let exercise = summary.appleExerciseTime.doubleValue(for: exerciseUnit)
            
            let energyGoal = summary.activeEnergyBurnedGoal.doubleValue(for: energyUnit)
            let standGoal = summary.appleStandHoursGoal.doubleValue(for: standUnit)
            let exerciseGoal = summary.appleExerciseTimeGoal.doubleValue(for: exerciseUnit)
            
            let energyAcvityRing = ActivityRingData(name: .calories, achieved: energy, goal: energyGoal)
            let moveAcvityRing = ActivityRingData(name: .move, achieved: exercise, goal: exerciseGoal)
            let standAcvityRing = ActivityRingData(name: .stand, achieved: stand, goal: standGoal)
            
            self?.activityRingPublisher.send([energyAcvityRing, moveAcvityRing, standAcvityRing])
        }
        storage.execute(query)
    }
}
