//
//  Timer.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/08/21.
//

import Foundation
import Combine

class WorkoutTimer {
    var generalTime: TimeInterval
    var restTime: TimeInterval
    var exerciseTime: TimeInterval
    var timeRate: TimeInterval
    var totalRestTime: TimeInterval
    var totalExerciseTime: TimeInterval
    var timer: AnyPublisher<Date, Never>
    
    init() {
        generalTime = 0
        restTime = 0
        exerciseTime = 0
        totalRestTime = 0
        totalExerciseTime = 0
        timeRate = 1/30
        timer = Timer
            .publish(every: timeRate, on: .current, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }
    
    init(generalTime: TimeInterval,
                  restTime: TimeInterval,
                  exerciseTime: TimeInterval,
                  timeRate: TimeInterval,
                  totalRestTime: TimeInterval,
                  totalExerciseTime: TimeInterval) {
        self.generalTime = generalTime
        self.restTime = restTime
        self.exerciseTime = exerciseTime
        self.timeRate = timeRate
        self.totalRestTime = totalRestTime
        self.totalExerciseTime = totalExerciseTime
        self.timer = Just(Date()).eraseToAnyPublisher()
    }
    
    func updateTimeForForegroundEntrance(state: WorkoutViewState, lastObservedDate: Date) {
        
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
    
    func updateTimer(state: WorkoutViewState) {
        if state == .exercise {
            updateExerciseTimer()
        } else {
            updateRestTimer()
        }
        updateGeneralTimer()
    }
    
    private func updateExerciseTimer() {
        exerciseTime += timeRate
        totalExerciseTime += timeRate
    }
    
    private func updateRestTimer() {
        restTime += timeRate
        totalRestTime += timeRate
    }
    
    private func updateGeneralTimer() {
        generalTime += timeRate
    }
    
    func resetRestTimer() {
        restTime = 0
    }
    
    func prepareForNextExercise() {
        resetRestTimer()
        exerciseTime = 0
    }
}
