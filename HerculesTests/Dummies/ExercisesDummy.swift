//
//  ExercisesDummy.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
import SwiftUI
@testable import Hercules

enum ExercisesDummy {
    static var userDummy: [Exercise] = [
        .init(name: "user1",
              id: UUID().uuidString,
              tags: [TagDummy.dummy1, TagDummy.dummy3]),
        .init(name: "user2",
              id: UUID().uuidString,
              tags: [TagDummy.dummy2, TagDummy.dummy5]),
        .init(name: "user3",
              id: UUID().uuidString,
              tags: [TagDummy.dummy1]),
        .init(name: "user4",
              id: UUID().uuidString,
              tags: [TagDummy.dummy4, TagDummy.dummy3]),
        .init(name: "user5",
              id: UUID().uuidString,
              tags: [TagDummy.dummy5])
    ]
    
    static var userSelected: [Exercise] = [
        userDummy[0],
        userDummy[2]
    ]
    
    static var defaultDummy: [Exercise] = [
        .init(name: "default1",
              id: UUID().uuidString,
              tags: [TagDummy.dummy1, TagDummy.dummy3]),
        .init(name: "default2",
              id: UUID().uuidString,
              tags: [TagDummy.dummy2, TagDummy.dummy5]),
        .init(name: "default3",
              id: UUID().uuidString,
              tags: [TagDummy.dummy1]),
        .init(name: "default4",
              id: UUID().uuidString,
              tags: [TagDummy.dummy4, TagDummy.dummy3]),
        .init(name: "default5",
              id: UUID().uuidString,
              tags: [TagDummy.dummy5])
    ]
    
    static var defaultSelected: [Exercise] = [
        defaultDummy[0],
        defaultDummy[2]
    ]
}
