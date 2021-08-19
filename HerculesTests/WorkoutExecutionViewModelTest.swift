//
//  WorkoutExecutionViewModelTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/08/21.
//

import XCTest
import Combine
import UIKit
@testable import Hercules

class WorkoutExecutionViewModelTest: XCTestCase {
    
    var sut: WorkoutExecutionViewModel!
    var notificationManager: WorkoutNotificationManagerDummy!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        notificationManager = WorkoutNotificationManagerDummy()
        sut = .init(workout: WorkoutDummy.dummy, notificationManager: notificationManager)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
    }
    
    func testPause() {
        sut.isPaused = true
        sut.tooglePause()
        
        XCTAssertEqual(sut.isPaused, false)
    }
    
    func testNextSeries() throws {
        sut.next()
        
        XCTAssertEqual(sut.viewState, .resting)
        XCTAssertEqual(sut.doneSeriesTimer.count, 1)
        XCTAssertEqual(sut.currentExercise, sut.workout.exercises[0])
    }
    
    func testNextExercise() throws {
        finishExercise()
        
        XCTAssertEqual(sut.currentExercise, sut.workout.exercises[1])
        XCTAssertEqual(sut.restTime, 0)
        XCTAssertEqual(sut.currentSerie, 1)
        XCTAssertEqual(sut.doneSeriesTimer, [])
        XCTAssertEqual(sut.exerciseTime, 0)
        XCTAssertEqual(sut.isPaused, true)
    }
    
    func testFinishWorkout() throws {
        finishWorkout()
    
        XCTAssertEqual(sut.isPaused, true)
        XCTAssertEqual(sut.isPresentingSummary, true)
    }
    
    func testSkipExercise() throws {
        sut.skip()
        
        XCTAssertEqual(sut.currentExercise, sut.workout.exercises[1])
    }
    
    func testFinishWorkoutWithSkip() throws {
        finishWorkoutBySkipping()
        
        XCTAssertEqual(sut.isPaused, true)
        XCTAssertEqual(sut.isPresentingSummary, true)
    }
    
    private func finishExercise() {
        for _ in 0...((sut.currentExercise.series*2)-1) {
            sut.next()
        }
    }
    
    private func finishWorkout() {
        let seriesCount = sut.workout.exercises.map{($0.series*2) - 1}.reduce(0, +) + sut.workout.exercises.count
        
        for _ in 0...seriesCount {
            sut.next()
        }
    }
    
    private func finishWorkoutBySkipping() {
        sut.workout.exercises.forEach {_ in
            sut.skip()
        }
    }
    
    private func finishRest() {
        sut.next()
        sut.next()
    }
    
    func testRestTimeProgressCalculation() {
        sut.workoutTimer.restTime = 30
        let restLimit = sut.currentExercise.restTime
        
        XCTAssertEqual(sut.restTimeProgress, (restLimit-sut.restTime)/restLimit)
    }
    
    func testTimerDuringExerciseInForeground() {
        clockSetup(isPaused: false,
                   viewState: .exercise,
                   timerLimit: 5,
                   expectationLimit: 6,
                   timerCompletion: nil)
        
        XCTAssertEqual(sut.exerciseTime.rounded(), 5)
        XCTAssertEqual(sut.generalTime.rounded(), 5)
    }
    
    func testTimerDuringRestInForeGround() {
        clockSetup(isPaused: false,
                   viewState: .resting,
                   timerLimit: 5,
                   expectationLimit: 6,
                   timerCompletion: nil)
        
        XCTAssertEqual(sut.restTime.rounded(), 5)
        XCTAssertEqual(sut.generalTime.rounded(), 5)
    }
    
    func testTimerDuringPauseInForeground() {
        clockSetup(isPaused: true,
                   viewState: .resting,
                   timerLimit: 5,
                   expectationLimit: 6,
                   timerCompletion: nil)
        
        XCTAssertEqual(sut.restTime.rounded(), 0)
        XCTAssertEqual(sut.generalTime.rounded(), 0)
    }
    
    func testTimerDuringExerciseInBackground() throws {
        
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        clockSetup(isPaused: false,
                   viewState: .exercise,
                   timerLimit: 5,
                   expectationLimit: 6) {
            NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        
        XCTAssertEqual(sut.exerciseTime.rounded(), 5)
        XCTAssertEqual(sut.generalTime.rounded(), 5)
    }
    
    func testTimerDuringRestInBackground() {
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        clockSetup(isPaused: false,
                   viewState: .resting,
                   timerLimit: 5,
                   expectationLimit: 6) {
            NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        
        XCTAssertEqual(sut.restTime.rounded(), 5)
        XCTAssertEqual(sut.generalTime.rounded(), 5)
    }
    
    func testTimerDuringPauseInBackground() {
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        clockSetup(isPaused: true,
                   viewState: .exercise,
                   timerLimit: 5,
                   expectationLimit: 6) {
            NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        
        XCTAssertEqual(sut.exerciseTime.rounded(), 0)
        XCTAssertEqual(sut.generalTime.rounded(), 0)
        XCTAssertEqual(sut.isOnForeground, true)
    }
    
    private func clockSetup(isPaused: Bool,
                            viewState: WorkoutViewState,
                            timerLimit: Double,
                            expectationLimit: Double,
                            timerCompletion: (() -> Void)?) {
        
        let expectation = expectation(description: "Wait a couple seconds so we can test the clock")
        
        sut.isPaused = isPaused
        sut.viewState = viewState
        
        sut.timer.sink { [weak self] _ in
            self?.sut.updateTimer()
        }.store(in: &cancellables)
        
        Timer
            .publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink {_ in
                if let action = timerCompletion {
                    action()
                }
                expectation.fulfill()
            }.store(in: &cancellables)
        
        waitForExpectations(timeout: expectationLimit)
    }
    
    func testAditionOfRestNotificationOnTheEndOfAnSerie() {
        sut.next()
        
        XCTAssertTrue(notificationManager.notifications.count > 0)
    }
    
    func testRemovalOfNotificationOnTheEndOfAnRest() {
        finishRest()
        
        XCTAssertTrue(notificationManager.notifications.isEmpty)
    }
    
    func testRemovalOfNotificationOnTheEndOfAnExercise() {
        finishExercise()
        
        XCTAssertTrue(notificationManager.notifications.isEmpty)
    }
    
    func testRemovalOfNotificationOnTheEndOfAnWorkout() {
        finishWorkout()
        
        XCTAssertTrue(notificationManager.notifications.isEmpty)
    }
    
    func testRemovalOfNotificationOnTheEndOfAnWorkoutBySkipping() {
        finishWorkoutBySkipping()
        
        XCTAssertTrue(notificationManager.notifications.isEmpty)
    }
    
}
