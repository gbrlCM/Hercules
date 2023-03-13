//
//  FeedViewTests.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 19/10/21.
//

import XCTest
import SnapshotTesting
import SwiftUI
import Habitat
@testable import Hercules

class FeedViewTests: XCTestCase {
    
    var sut: FeedView!
    var dateHelper: DatesHelperMock!
    var viewModel: FeedViewModel!
    var workoutStorageMock: WorkoutsStorageMock!
    var healthStorageMock: HealthStorageMock!

    override func setUp() {
        dateHelper = DatesHelperMock(offset: 350)
        workoutStorageMock = WorkoutStorageDummy.standard
        healthStorageMock = HealthStorageMock()
        
        viewModel = setupModelDependencies(workouts: workoutStorageMock, health: healthStorageMock, date: dateHelper)
        sut = FeedView(viewModel: viewModel)
        isRecording = false
    }

    override func tearDown() {
        dateHelper = nil
        workoutStorageMock = nil
        healthStorageMock = nil
        viewModel = nil
        sut = nil
    }
    
    func setupModelDependencies(workouts: WorkoutsStorage, health: HealthStorage, date: DatesHelper) -> FeedViewModel {
        Habitat[\.workoutsStorage] = workouts
        Habitat[\.healthStorage] = health
        Habitat[\.dateHelper] = date
        return FeedViewModel()
    }

    func testViewWithAllDataFulfiled() {
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithEmptyData() {
        sut.viewModel = setupModelDependencies(workouts: WorkoutStorageDummy.empty, health: healthStorageMock, date: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithoutSessions() {
        sut.viewModel = setupModelDependencies(workouts: WorkoutStorageDummy.noSessions, health: healthStorageMock, date: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithOutdatedWorkoutsAndNoSessions() {
        sut.viewModel = setupModelDependencies(workouts: WorkoutStorageDummy.outdatedNoSessions, health: healthStorageMock, date: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithOutdatedWorkoutsAndWithSessions() {
        sut.viewModel = setupModelDependencies(workouts: WorkoutStorageDummy.outdated, health: healthStorageMock, date: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }

}
