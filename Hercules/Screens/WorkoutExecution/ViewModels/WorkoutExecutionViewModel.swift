//
//  WorkoutExecutionViewModels.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 25/07/21.
//

import Foundation
import SwiftUI
import Combine

class WorkoutExecutionViewModel: ObservableObject {
    
    enum ViewState {
        case exercise, resting
    }
    
    @Published
    var isPaused: Bool
    @Published
    var workout: Workout
    @Published
    var generalTime: TimeInterval
    @Published
    var restTime: TimeInterval
    @Published
    var exerciseTime: TimeInterval
    @Published
    var viewState: ViewState
    @Published
    var doneSeriesTimer: [TimeInterval]
    @Published
    private var currentExerciseIndex: Int
    
    @Published
    var isPresentingSummary = false
    @Published
    var isPresentingExerciseList = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var currentExercise: WorkoutExercise {
        workout.exercises[currentExerciseIndex]
    }
    
    var currentSerie: Int {
        doneSeriesTimer.count + 1
    }
    
    var restTimeLimit: TimeInterval {
        currentExercise.restTime
    }
    
    var totalRestTime: TimeInterval = 0
    var totalExerciseTime: TimeInterval = 0
    
    private var isOnForeground: Bool
    private let timeCoeficient: TimeInterval = 1/30
    private var previousState: ViewState
    private var startDate: Date
    private var lastObservedDate: Date
    private var notificationManager: NotificationManager
    private let storage: SessionStorage
    private let healthStorage = HealthStorage()
    
    
    var restTimeProgress: TimeInterval {
        (restTimeLimit - restTime)/restTimeLimit
    }
    
    private var timeUntilStartedExercise: TimeInterval {
        var timeUntilStartedExercise: TimeInterval = 0
        
        if currentSerie > 0 {
            timeUntilStartedExercise = doneSeriesTimer.reduce(0, +)
        }
        
        return timeUntilStartedExercise
    }
    
    var timer = Timer
        .publish(every: 1/30, on: .main, in: .common)
        .autoconnect()
    
    init(workout: Workout, notificationManager: NotificationManager = WorkoutNotificationManager(), storage: SessionStorage = SessionStorageImpl()) {
        self.workout = workout
        currentExerciseIndex = 0
        
        generalTime = 0
        exerciseTime = 0
        restTime = 0
        viewState = .exercise
        startDate = Date()
        doneSeriesTimer = []
        previousState = .exercise
        isOnForeground = true
        isPaused = true
        lastObservedDate = startDate
        self.notificationManager = notificationManager
        self.storage = storage
        initiateBindings()
    }
    
    func initiateBindings() {
        NotificationCenter
            .default
            .publisher(for: UIApplication.willResignActiveNotification)
            .sink {[weak self] _ in
                self?.prepareClockForBackground()
            }
            .store(in: &cancellables)
        
        NotificationCenter
            .default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .sink {[weak self] _ in
                self?.prepareClockForForeground()
            }
            .store(in: &cancellables)
    }
    
    private func prepareClockForBackground() {
        isOnForeground = false
        lastObservedDate = Date()
    }
    
    private func prepareClockForForeground() {
        
        guard !isPaused else { return }
        
        isOnForeground = true
        let now = Date()
        let timeInBackground = now.timeIntervalSince(lastObservedDate)
        
        if viewState == .exercise {
            exerciseTime += timeInBackground
            totalExerciseTime += timeInBackground
        } else {
            restTime += timeInBackground
            totalRestTime += timeInBackground
        }
        
        generalTime += timeInBackground
    }
    
    func updateTimer() {
        if !isPaused && isOnForeground{
            if viewState == .exercise {
                updateExerciseTimer()
            } else {
                updateRestTimer()
            }
            updateGeneralTimer()
        }
    }
    
    private func updateExerciseTimer() {
        exerciseTime += timeCoeficient
        totalExerciseTime += timeCoeficient
    }
    
    private func updateRestTimer() {
        restTime += timeCoeficient
        totalRestTime += timeCoeficient
    }
    
    private func updateGeneralTimer() {
        generalTime += timeCoeficient
    }
    
    func skip() {
        nextExercise()
    }
    
    func next() {
        if currentSerie < currentExercise.series {
            nextSerie()
        } else {
            nextExercise()
        }
    }
    
    private func nextSerie() {
        if viewState == .exercise {
            let time = exerciseTime - timeUntilStartedExercise
            doneSeriesTimer.append(time)
            viewState = .resting
            notificationManager.send(timeInterval: restTimeLimit)
        } else {
            notificationManager.cancel()
            viewState = .exercise
            restTime = 0
        }
    }
    
    private func nextExercise() {
        notificationManager.cancel()
        if currentExerciseIndex < workout.exercises.count-1 {
            updateExercise()
        } else {
            finishWorkout()
        }
    }
    
    private func updateExercise() {
        currentExerciseIndex += 1
        resetExercise()
    }
    
    private func resetExercise() {
        isPaused = true
        restTime = 0
        viewState = .exercise
        doneSeriesTimer = []
        exerciseTime = 0
    }
    
    func finishWorkout() {
        isPaused = true
        isPresentingSummary = true
    }
    
    func saveWorkoutSession() {
        guard let workoutId = workout.objectID else { return }
        
        let startDate = startDate
        let generalTime = generalTime
        let totalRestTime = totalRestTime
        let totalExerciseTime = totalExerciseTime
        let workoutName = workout.name
        let exerciseCount = workout.exercises.count
        let seriesCount = workout.exercises.map{$0.series}.reduce(0, +)
        
        healthStorage.saveWorkout(startDate: startDate, duration: generalTime) {[weak self] id in
            
            let session = WorkoutSession(healthStoreID: id?.uuidString,
                                         date: startDate,
                                         totalTime: generalTime,
                                         restTime: totalRestTime,
                                         exerciseTime: totalExerciseTime,
                                         workoutName: workoutName,
                                         exerciseCount: exerciseCount,
                                         seriesCount: seriesCount)
            print(session)
            self?.storage.saveSession(session, workoutID: workoutId)
        }
    }
    
    func tooglePause() {
        isPaused.toggle()
    }
}
