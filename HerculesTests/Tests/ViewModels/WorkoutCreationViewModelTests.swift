//
//  WorkoutCreationViewModelTests.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 18/10/21.
//

import XCTest
@testable import Hercules

class WorkoutCreationViewModelTests: XCTestCase {
    
    var sut: WorkoutCreationViewModel!
    var mockStorage: WorkoutsStorageMock!

    override func setUp() {
        mockStorage = WorkoutsStorageMock()
        sut = WorkoutCreationViewModel(storage: mockStorage)
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
        
        sut.saveWorkout()
        
        XCTAssertEqual(dummy, mockStorage.lastSavedWorkout!)
        
    }
    
    func testUserDidUpdateWorkout() {
        var dummy = WorkoutDummy.dummy
        dummy.objectID = URL(fileURLWithPath: "")
        sut = .init(workout: dummy, storage: mockStorage)
        
        sut.nameField = "New Name"
        
        sut.saveWorkout()
        
        XCTAssertEqual(mockStorage.lastSavedWorkout!.name, "New Name")
        
    }

}
