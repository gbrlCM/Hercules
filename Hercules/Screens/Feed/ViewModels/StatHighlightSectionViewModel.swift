//
//  StatHighlightSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct StatHighlightSectionViewModel: HorizontalSectionViewModel {
    
    var elementCount: Int
    var sectionTitle: String
    var emptySectionMessage: String
    
    var cardsViewModels: [StatHighlightsCardViewModel]
    
    init() {
        cardsViewModels = Array(repeating: StatHighlightsCardViewModel(), count: 4)
        elementCount = cardsViewModels.count
        sectionTitle = "Stats Highlights"
        emptySectionMessage = "No Status captured yet"
    }
    
    init(sectionTitle: String, emptySectionMessage: String, cardsViewModels: [StatHighlightsCardViewModel]) {
        self.cardsViewModels = cardsViewModels
        self.elementCount = cardsViewModels.count
        self.sectionTitle = sectionTitle
        self.emptySectionMessage = emptySectionMessage
    }
    
}
