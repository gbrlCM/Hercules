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
    var timer: WorkoutTimer!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        notificationManager = WorkoutNotificationManagerDummy()
        timer = WorkoutTimer()
        sut = .init(workout: WorkoutDummy.dummy, notificationManager: notificationManager, timer: timer)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        cancellables.forEach { $0.cancel() }
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
        syncClockSetup(isPaused: false, viewState: .exercise)
        XCTAssert(sut.exerciseTime == 1/30)
        XCTAssert(sut.generalTime == 1/30)
        XCTAssert(sut.restTime == 0)
    }
    
    func testTimerDuringRestInForeGround() {
        syncClockSetup(isPaused: false, viewState: .resting)
        
        XCTAssertEqual(sut.restTime, 1/30)
        XCTAssertEqual(sut.generalTime, 1/30)
        XCTAssertEqual(sut.exerciseTime, 0)
    }
    
    func testTimerDuringPauseInForeground() {
        syncClockSetup(isPaused: true, viewState: .resting)
        
        XCTAssertEqual(sut.restTime.rounded(), 0)
        XCTAssertEqual(sut.generalTime.rounded(), 0)
    }
    
    func testTimerDuringExerciseInBackground() throws {
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        clockSetup(isPaused: false,
                   viewState: .exercise,
                   timerLimit: 1,
                   expectationLimit: 2) {
            NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        XCTAssertEqual(sut.exerciseTime.rounded(), 1)
        XCTAssertEqual(sut.generalTime.rounded(), 1)
    }
    
    func testTimerDuringRestInBackground() {
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        clockSetup(isPaused: false,
                   viewState: .resting,
                   timerLimit: 1,
                   expectationLimit: 2) {
            NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        
        XCTAssertEqual(sut.restTime.rounded(), 1)
        XCTAssertEqual(sut.generalTime.rounded(), 1)
    }
    
    func testTimerDuringPauseInBackground() {
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        clockSetup(isPaused: true,
                   viewState: .exercise,
                   timerLimit: 1,
                   expectationLimit: 2) {
            NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        
        
        XCTAssertEqual(sut.exerciseTime.rounded(), 0)
        XCTAssertEqual(sut.generalTime.rounded(), 0)
        XCTAssertEqual(sut.isOnForeground, true)
    }
    
    private func syncClockSetup(isPaused: Bool, viewState: WorkoutViewState) {
        sut.isPaused = isPaused
        sut.viewState = viewState
        
        sut.updateTimer()
    }
    
    private func clockSetup(isPaused: Bool,
                            viewState: WorkoutViewState,
                            timerLimit: Double,
                            expectationLimit: Double,
                            timerCompletion: (() -> Void)?) {
        
        let expectation = expectation(description: "Wait a couple seconds so we can test the clock")
        
        sut.isPaused = isPaused
        sut.viewState = viewState
        
        let before: Date = Date()
        
        let timer = Timer.scheduledTimer(withTimeInterval: timerLimit, repeats: false) {_ in
            if let action = timerCompletion {
                action()
            }
            
            let dif = Date().timeIntervalSince(before)
            print("Timer: \(dif)")
            expectation.fulfill()
        }
        
        timer.tolerance = 0.2
        
        sut.timer.sink { [weak self] _ in
            self?.sut.updateTimer()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
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
