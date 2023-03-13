//
//  WorkoutViewModelTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/11/21.
//

import XCTest
import Habitat
@testable import Hercules

class WorkoutViewModelTest: XCTestCase {

    var sut: WorkoutViewModel!
    var storage: WorkoutsStorageMock!
    
    override func setUp() {
        storage = .init()
        Habitat[\.workoutsStorage] = storage
        sut = .init(workout: WorkoutDummy.dummyWithID)
        
    }
    
    override func tearDown() {
        sut = nil
        storage = nil
    }
    
    func testDaysCollection() {
        XCTAssertEqual(sut.days, ["S", "M", "T", "W", "T", "F", "S"])
    }
    
    func testFormatedDate() {
        XCTAssertEqual(sut.endDateFormatted, "12/31/69")
    }
    
    func testStartEditingBinding() {
        sut.startEditing()
        XCTAssertEqual(sut.isEditing, true)
    }
    
    func testStartWorkoutBinding() {
        sut.startWorkout()
        XCTAssertEqual(sut.isPlayingWorkout, true)
    }
    
    func testShowAlertBinding() {
        sut.presentDeleteAlert()
        XCTAssertEqual(sut.isShowingDeleteAlert, true)
    }

}
