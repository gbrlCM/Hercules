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
    
    @Published
    var isPaused: Bool
    @Published
    var workout: Workout
    @Published
    var viewState: WorkoutViewState
    @Published
    var doneSeriesTimer: [TimeInterval]
    @Published
    private var currentExerciseIndex: Int
    @Published
    var isPresentingSummary = false
    @Published
    var isPresentingExerciseList = false
    
    @Published
    var workoutTimer: WorkoutTimer
    private var cancellables = Set<AnyCancellable>()
    var isOnForeground: Bool
    private var startDate: Date
    private var lastObservedDate: Date
    private var notificationManager: NotificationManager
    private let storage: SessionStorage
    private let healthStorage: HealthStorage
    
    var currentExercise: WorkoutExercise {
        workout.exercises[currentExerciseIndex]
    }
    
    var currentSerie: Int {
        doneSeriesTimer.count + 1
    }
    
    var restTimeLimit: TimeInterval {
        currentExercise.restTime
    }
    
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
    
    var timer: AnyPublisher<Date, Never> {
        workoutTimer.timer
    }
    
    var generalTime: TimeInterval {
        workoutTimer.generalTime
    }
    
    var restTime: TimeInterval {
        workoutTimer.restTime
    }
    
    var exerciseTime: TimeInterval {
        workoutTimer.exerciseTime
    }
    
    var totalRestTime: TimeInterval {
        workoutTimer.totalRestTime
    }
    var totalExerciseTime: TimeInterval {
        workoutTimer.totalExerciseTime
    }
    
    init(workout: Workout,
         notificationManager: NotificationManager = WorkoutNotificationManager(),
         storage: SessionStorage = SessionStorageImpl(),
         timer: WorkoutTimer = WorkoutTimer(),
         healthStorage: HealthStorage = HealthStorageImpl()) {
        self.workout = workout
        self.currentExerciseIndex = 0
        self.viewState = .exercise
        self.startDate = Date()
        self.doneSeriesTimer = []
        self.isOnForeground = true
        self.isPaused = true
        self.lastObservedDate = startDate
        self.notificationManager = notificationManager
        self.storage = storage
        self.workoutTimer = timer
        self.healthStorage = healthStorage
        initiateBindings()
    }
    
    func initiateBindings() {
        NotificationCenter
            .default
            .publisher(for: UIApplication.willResignActiveNotification)
            .sink(receiveValue: prepareClockForBackground)
            .store(in: &cancellables)
        
        
        NotificationCenter
            .default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .sink(receiveValue: prepareClockForForeground)
            .store(in: &cancellables)
    }
    
    private func prepareClockForBackground(_ notification: Notification) {
        isOnForeground = false
        lastObservedDate = Date()
    }
    
    private func prepareClockForForeground(_ notification: Notification) {
        isOnForeground = true
        guard !isPaused else { return }
        workoutTimer.updateTimeForForegroundEntrance(state: viewState, lastObservedDate: lastObservedDate)
    }
    
    func updateTimer() {
        if !isPaused && isOnForeground {
            workoutTimer.updateTimer(state: viewState)
        }
    }
    
    func skip() {
        nextExercise()
    }
    
    func next() {
        if currentSerie <= currentExercise.series {
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
            workoutTimer.resetRestTimer()
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
        viewState = .exercise
        doneSeriesTimer = []
        workoutTimer.prepareForNextExercise()
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
            self?.storage.saveSession(session, workoutID: workoutId)
        }
    }
    
    func tooglePause() {
        isPaused.toggle()
    }
}
