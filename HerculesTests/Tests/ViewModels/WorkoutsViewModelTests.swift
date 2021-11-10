//
//  WorkoutsViewModelTests.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 27/10/21.
//

import XCTest
@testable import Hercules

class WorkoutsViewModelTests: XCTestCase {
    var sut: WorkoutsViewModel!
    var workoutStorageDummy: WorkoutsStorageMock!

    override func setUp() {
        workoutStorageDummy = WorkoutStorageDummy.standard
        sut = .init(dataStorage: workoutStorageDummy)
    }
    
    override func tearDown() {
        sut = nil
        workoutStorageDummy = nil
    }

    func testDateStringGeneration() {
        let workout = workoutStorageDummy.workouts.first!
        let dateString = sut.dateString(for: workout)
        
        XCTAssertEqual(dateString, "Sun - Tue - Wed - Thu - Fri")
    }
    
    func testDataArrivalInForeground() {
        let list = [WorkoutDummy.dummy]
        simDataArrival(isOnForeground: true, list: list)
        XCTAssertEqual(sut.workouts, list)
    }
    
    func testDataArrivalOnBackground() {
        let list = [WorkoutDummy.dummy]
        simDataArrival(isOnForeground: false, list: list)
        XCTAssertEqual(sut.workouts, workoutStorageDummy.workouts)
    }
    
    private func simDataArrival(isOnForeground: Bool, list: [Workout]) {
        sut.isOnForeground = isOnForeground
        workoutStorageDummy.allWorkoutSubjects.send([WorkoutDummy.dummy])
    }
    
    func testWorkoutDeletionHandler() {
        var workoutsAfterDeletion = workoutStorageDummy.workouts
        workoutsAfterDeletion.remove(at: 2)

        sut.deleteWorkout(offset: 2)
        
        XCTAssertEqual(sut.workouts, workoutsAfterDeletion)
    }

}
