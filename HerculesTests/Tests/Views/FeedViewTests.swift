//
//  FeedViewTests.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 19/10/21.
//

import XCTest
import SnapshotTesting
import SwiftUI
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
        viewModel = FeedViewModel(dataStorage: workoutStorageMock, healthStorage: healthStorageMock, dateHelper: dateHelper)
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

    func testViewWithAllDataFulfiled() {
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithEmptyData() {
        sut.viewModel = FeedViewModel(dataStorage: WorkoutStorageDummy.empty, healthStorage: healthStorageMock, dateHelper: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithoutSessions() {
        sut.viewModel = FeedViewModel(dataStorage: WorkoutStorageDummy.noSessions, healthStorage: healthStorageMock, dateHelper: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithOutdatedWorkoutsAndNoSessions() {
        sut.viewModel = FeedViewModel(dataStorage: WorkoutStorageDummy.outdatedNoSessions, healthStorage: healthStorageMock, dateHelper: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }
    
    func testViewWithOutdatedWorkoutsAndWithSessions() {
        sut.viewModel = FeedViewModel(dataStorage: WorkoutStorageDummy.outdated, healthStorage: healthStorageMock, dateHelper: dateHelper)
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }

}
