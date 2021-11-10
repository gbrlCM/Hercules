//
//  WorkoutViewTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/11/21.
//

import XCTest
import SnapshotTesting
@testable import Hercules
import SwiftUI

class WorkoutViewTest: XCTestCase {

    var sut: WorkoutView!
    var viewModel: WorkoutViewModel!
    var host: UIViewController!
    
    override func setUp() {
        viewModel = WorkoutViewModel(workout: .constant(WorkoutDummy.dummyWithID), storage: WorkoutsStorageMock())
        sut = WorkoutView(viewModel: viewModel)
        host = UIHostingController(rootView: sut)
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
    }
    
    func testViewLayout() {
        assertSnapshot(matching: host, as: .image)
    }

}
