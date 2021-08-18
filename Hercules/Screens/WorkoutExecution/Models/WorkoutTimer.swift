//
//  Timer.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/08/21.
//

import Foundation
import Combine

struct WorkoutTimer {
    var generalTime: TimeInterval
    var restTime: TimeInterval
    var exerciseTime: TimeInterval
    var timeRate: TimeInterval
    var totalRestTime: TimeInterval = 0
    var totalExerciseTime: TimeInterval = 0
    let timer: AnyPublisher<Date, Never>
    
    init() {
        generalTime = 0
        restTime = 0
        exerciseTime = 0
        timeRate = 1/30
        timer = Timer
            .publish(every: timeRate, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }
    
    mutating func updateTimeForForegroundEntrance(state: WorkoutViewState, lastObservedDate: Date) {
        
        let now = Date()
        let timeInBackground = now.timeIntervalSince(lastObservedDate)
        
        if state == .exercise {
            exerciseTime += timeInBackground
            totalExerciseTime += timeInBackground
        } else {
            restTime += timeInBackground
            totalRestTime += timeInBackground
        }
        
        generalTime += timeInBackground
    }
    
    mutating func updateTimer(state: WorkoutViewState) {
        if state == .exercise {
            updateExerciseTimer()
        } else {
            updateRestTimer()
        }
        updateGeneralTimer()
    }
    
    private mutating func updateExerciseTimer() {
        exerciseTime += timeRate
        totalExerciseTime += timeRate
    }
    
    private mutating func updateRestTimer() {
        restTime += timeRate
        totalRestTime += timeRate
    }
    
    private mutating func updateGeneralTimer() {
        generalTime += timeRate
    }
    
    mutating func resetRestTimer() {
        restTime = 0
    }
    
    mutating func prepareForNextExercise() {
        resetRestTimer()
        exerciseTime = 0
    }
}
