//
//  ExerciseNames.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation
import SwiftUI

struct Exercise: Decodable, Identifiable {
    let name: String
    let id: String
    let tags: [ExerciseTag]
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case tags
    }
    
    init(entity: ADExercise) {
        guard
            let name = entity.name,
            let id = entity.id,
            let tags = entity.tags?.allObjects as? [ADExerciseTags]
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        let structTags = tags.compactMap{ ExerciseTag(entity: $0) }
        
        self.name = name
        self.id = id.uuidString
        self.tags = structTags
    }
    
    init(name: String, id: String, tags: [ExerciseTag]) {
        self.name = name
        self.id = id
        self.tags = tags
    }
    
    init() {
        self.name = "swing"
        self.id = "someId"
        self.tags = [ExerciseTag(), ExerciseTag()]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let decodedName = try container.decode(String.self, forKey: .name)
        let id = try container.decode(String.self, forKey: .id)
        let tags = try container.decode([String].self, forKey: .tags)
        
        self.name = decodedName
        self.id = id
        self.tags = tags.map { ExerciseTag(name: $0, color: Color($0))}
    }
}

