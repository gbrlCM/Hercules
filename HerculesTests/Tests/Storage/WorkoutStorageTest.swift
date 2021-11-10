//
//  WorkoutStorageTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/11/21.
//

import XCTest
import Combine
@testable import Hercules
import CoreData

class WorkoutStorageTest: XCTestCase {

    var sut: WorkoutsStorageImpl!
    var dataStorage: DataStorage!
    @Published
    var workouts: [Workout]!
    
    override func setUp() {
        dataStorage = DataStorage(.inMemory)
        sut = .init(dataStorage: dataStorage)
        sut.emitAllWorkoutSubjects()
        workouts = []
        sut
            .allWorkoutSubjects
            .map { Optional($0) }
            .assign(to: &$workouts)
    }
    
    override func tearDown() {
        sut = nil
        dataStorage = nil
        workouts = nil
    }
    
    func testSavingWorkout() {
        let dummy = WorkoutDummy.dummy
        sut.saveWorkout(dummy)
        
        XCTAssertEqual(workouts.count, 1)
        XCTAssertEqual(dummy, workouts.first!)
    }
    
    func testWorkoutEditionWithSameExercises() {
        var dummy = WorkoutDummy.dummy
        
        sut.saveWorkout(dummy)
        
        dummy = workouts.first!
        dummy.name = "Edited"
        sut.editWorkout(dummy)
        
        XCTAssertEqual(workouts.count, 1)
        XCTAssertEqual(workouts.first!, dummy)
    }
    
    func testWorkoutEditionWithNewExercises() {
        var dummy = WorkoutDummy.dummy
        
        sut.saveWorkout(dummy)
        dummy = workouts.first!
        dummy.name = "Edited"
        dummy.exercises = [
        WorkoutExercise(
            exerciseName: "Edited",
            exerciseID: UUID(),
            intesityMetric: .areaOfRm,
            intesityValue: 1,
            repetitions: 2,
            series: 3,
            restTime: 4)
        ]
        sut.editWorkout(dummy)
        
        XCTAssertEqual(workouts.count, 1)
        XCTAssertEqual(workouts.first!, dummy)
    }
    
    func testWorkoutDeletion() {
        let dummy = WorkoutDummy.dummy
        sut.saveWorkout(dummy)
        sut.deleteWorkout(workouts.first!)
        XCTAssertEqual(workouts, [])
    }
}
