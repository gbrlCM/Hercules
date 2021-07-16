//
//  ThisWeekSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct ThisWeekSectionViewModel: HorizontalSectionViewModel {
    
    var elementCount: Int
    var sectionTitle: String
    var emptySectionMessage: String
    let cardViewModels: [ThisWeekCardViewModel]
    
    init() {
        cardViewModels = Array.init(repeating: ThisWeekCardViewModel(), count: 7)
        elementCount = cardViewModels.count
        sectionTitle = "This Week"
        emptySectionMessage = "No exercises echeaduled"
    }
    
    init(sectionTitle: String, emptySectionMessage: String, cardViewModels: [ThisWeekCardViewModel]) {
        self.cardViewModels = cardViewModels
        self.elementCount = cardViewModels.count
        self.sectionTitle = sectionTitle
        self.emptySectionMessage = emptySectionMessage
    }
}
