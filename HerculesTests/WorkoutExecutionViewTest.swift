//
//  WorkoutExecutionViewTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/08/21.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import Hercules

class WorkoutExecutionViewTest: XCTestCase {
    
    var sut: WorkoutExecutionView!
    

    override func setUp() {
        let viewModel = WorkoutExecutionViewModel(workout: WorkoutDummy.dummy)
        sut = WorkoutExecutionView(viewModel: viewModel)
        isRecording = false
    }

    override func tearDown() {
        sut = nil
    }

    func testViewLayout() {
        let host = UIHostingController(rootView: sut)
        assertSnapshot(matching: host, as: .image)
    }

}
