//
//  WorkoutsViewTests.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 27/10/21.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import Hercules

class WorkoutsViewTests: XCTestCase {
    var sut: WorkoutsView!
    var viewModel: WorkoutsViewModel!

    override func setUp() {
        viewModel = .init(dataStorage: WorkoutStorageDummy.standard)
        sut = .init(viewModel: viewModel)
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
    }

    func testViewWithAllDataFulfiled() {
        assertSutSnapshot(withStorage: WorkoutStorageDummy.standard)
    }
    
    func testViewWithEmptyData() {
        assertSutSnapshot(withStorage: WorkoutStorageDummy.empty)
    }
    
    func testViewWithoutSessions() {
        assertSutSnapshot(withStorage: WorkoutStorageDummy.noSessions)
    }
    
    func testViewWithOutdatedWorkoutsAndNoSessions() {
        assertSutSnapshot(withStorage: WorkoutStorageDummy.outdatedNoSessions)
    }
    
    func testViewWithOutdatedWorkoutsAndWithSessions() {
        assertSutSnapshot(withStorage: WorkoutStorageDummy.outdated)
    }
    
    private func assertSutSnapshot(withStorage storage: WorkoutsStorage) {
        viewModel = .init(dataStorage: storage)
        sut.viewModel = viewModel
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }

}
