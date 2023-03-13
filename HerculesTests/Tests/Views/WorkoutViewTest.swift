//
//  WorkoutViewTest.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 09/11/21.
//

import XCTest
import SnapshotTesting
import Habitat
@testable import Hercules
import SwiftUI

class WorkoutViewTest: XCTestCase {

    var sut: WorkoutView!
    var viewModel: WorkoutViewModel!
    var host: UIViewController!
    
    override func setUp() {
        Habitat[\.workoutsStorage] = WorkoutsStorageMock()
        viewModel = WorkoutViewModel(workout: WorkoutDummy.dummyWithID)
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
