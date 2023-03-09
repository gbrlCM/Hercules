//
//  ExerciseListViewModelTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import XCTest
@testable import Hercules

class ExerciseListViewModelTest: XCTestCase {
    
    var sut: ExercisesListModel!
    var storageDummy: ExerciseStorageDummy!
    
    override func setUp() {
        storageDummy = ExerciseStorageDummy()
        sut = ExercisesListModel(storage: storageDummy)
    }
    
    override func tearDown() {
        storageDummy = nil
        sut = nil
    }
    
    func testDefaultListTagAddition() {
        sut.toggleTag(of: TagDummy.dummy1)
        XCTAssertEqual(sut.defaultExercises, ExercisesDummy.defaultSelected)
    }
    
    func testDefaultListTagRemoval() {
        sut.toggleTag(of: TagDummy.dummy1)
        sut.toggleTag(of: TagDummy.dummy1)
        XCTAssertEqual(sut.defaultExercises, ExercisesDummy.defaultDummy)
    }
    
    func testUserListTagAddition() {
        sut.toggleTag(of: TagDummy.dummy1)
        XCTAssertEqual(sut.userExercises, ExercisesDummy.userSelected)
    }
    
    func testUserListTagRemoval() {
        sut.toggleTag(of: TagDummy.dummy1)
        sut.toggleTag(of: TagDummy.dummy1)
        XCTAssertEqual(sut.userExercises, ExercisesDummy.userDummy)
    }
    
    func testTagColor() {
        let color = sut.colorForTag(named: TagDummy.dummy1.name)
        XCTAssertEqual(color, .blue)
    }
}
