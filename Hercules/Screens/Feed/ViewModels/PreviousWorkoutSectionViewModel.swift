//
//  PreviousWorkoutSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct PreviousWorkoutSectionViewModel {
    
    var sectionTitle: StringKey
    var emptySectionMessage: String
    var cardsViewModels: [PreviousWorkoutCellViewModel]
    
    init() {
        sectionTitle = .previousWorkouts
        emptySectionMessage = "There are no previous workouts"
        cardsViewModels = Array(repeating: PreviousWorkoutCellViewModel(), count: 20)
    }
    
    init(cardsViewModels: [PreviousWorkoutCellViewModel]) {
        self.sectionTitle = .previousWorkouts
        self.emptySectionMessage = "There are no previous workouts"
        self.cardsViewModels = cardsViewModels
    }
}
