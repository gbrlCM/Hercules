//
//  TagDummy.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 16/08/21.
//

import Foundation
import SwiftUI
@testable import Hercules

enum TagDummy {
    static var dummies: [ExerciseTag] = [
        .init(name: "tag1", color: .blue),
        .init(name: "tag2", color: .red),
        .init(name: "tag3", color: .orange),
        .init(name: "tag4", color: .purple),
        .init(name: "tag5", color: .pink)
    ]
    
    static var dummy1: ExerciseTag = .init(name: "tag1", color: .blue)
    static var dummy2: ExerciseTag = .init(name: "tag2", color: .red)
    static var dummy3: ExerciseTag = .init(name: "tag3", color: .orange)
    static var dummy4: ExerciseTag = .init(name: "tag4", color: .purple)
    static var dummy5: ExerciseTag = .init(name: "tag5", color: .pink)
}
