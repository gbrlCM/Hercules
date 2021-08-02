//
//  ExerciseTag.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation
import SwiftUI

struct ExerciseTag: Decodable, Hashable, Equatable {
    let name: String
    let color: Color
    let isUserCreated: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, color
    }
    
    init(entity: ADExerciseTags) {
        guard
            let name = entity.name,
            let color = entity.color
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        self.name = name
        self.color = Color(color)
        self.isUserCreated = true
    }
    
    init(name: String, color: Color) {
        self.name = name
        self.color = color
        self.isUserCreated = true
    }
    
    init() {
        self.name = "swing"
        self.color = .green
        self.isUserCreated = false
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let decodedName = try container.decode(String.self, forKey: .name)
        let decodedColor = try container.decode(String.self, forKey: .color)
        
        self.name = decodedName
        self.color = Color(decodedColor)
        self.isUserCreated = false
    }
}
