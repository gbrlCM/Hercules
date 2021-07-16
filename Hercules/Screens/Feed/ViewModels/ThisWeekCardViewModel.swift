//
//  ThisWeekCardViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct ThisWeekCardViewModel {
    
    let exerciseName: String
    let exerciseDate: String
    
    init() {
        exerciseName = "Leg - 8 exercises"
        exerciseDate = "Today"
    }
    
    init(name: String, dateString: String) {
        exerciseName = name
        exerciseDate = dateString
    }
    
}
