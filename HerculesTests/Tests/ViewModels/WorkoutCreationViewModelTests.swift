//
//  WorkoutCreationViewModelTests.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 18/10/21.
//

import XCTest
import Habitat
@testable import Hercules

class WorkoutCreationViewModelTests: XCTestCase {
    
    var sut: WorkoutCreationViewModel!
    var mockStorage: WorkoutsStorageMock!

    override func setUp() {
        mockStorage = WorkoutsStorageMock()
        Habitat[\.workoutsStorage] = mockStorage
        sut = WorkoutCreationViewModel()
    }

    override func tearDown() {
        mockStorage = nil
        sut = nil
    }

    func testUserDidFinishForm() {
        sut.nameField = "Testing Naming field"
        sut.createdExercises.append(.init(exerciseName: "Test",
                                          exerciseID: UUID(),
                                          intesityMetric: .areaOfRm,
                                          intesityValue: 24,
                                          repetitions: 12,
                                          series: 4,
                                          restTime: 60))
        
        XCTAssertFalse(sut.isStillCreating)
    }
    
    func testUserDidSaveAWorkout() {
        let dummy: Workout = WorkoutDummy.dummy
        
        sut.nameField = dummy.name
        sut.createdExercises = dummy.exercises
        sut.areaOfFocus = dummy.focusArea.rawValue
        sut.endDate = dummy.finalDate
        sut.daysSelected = Array(repeating: false, count: 7)
            .enumerated()
            .map { (index, element) in
                dummy.daysOfTheWeek.contains(index+1)
            }
        
        var didDismiss = false
        
        sut.dismissCreation = { didDismiss = true }
        
        sut.saveWorkout()
        
        XCTAssertEqual(dummy, mockStorage.lastSavedWorkout!)
        XCTAssertTrue(didDismiss)
        
    }
    
    func testUserDidUpdateWorkout() {
        let dummy = WorkoutDummy.dummyWithID
        Habitat[\.workoutsStorage] = mockStorage
        sut = .init(workout: dummy)
        
        sut.nameField = "New Name"
        
        var didDismiss = false
        
        sut.dismissCreation = { didDismiss = true }
        
        sut.saveWorkout()
        
        XCTAssertEqual(mockStorage.lastUpdatedWorkout?.name ?? "empty", "New Name")
        XCTAssertTrue(didDismiss)
        
    }

}
