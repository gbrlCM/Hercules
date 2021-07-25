//
//  StatHighlightSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct StatHighlightSectionViewModel {
    
    var sectionTitle: StringKey
    
    @Binding
    var cardsViewModels: [StatHighlightsCardViewModel]
    
    init() {
        _cardsViewModels = .constant(Array(repeating: StatHighlightsCardViewModel(), count: 4))
        sectionTitle = .statsHighlights
    }
    
    init(sectionTitle: StringKey, cardsViewModels: Binding<[StatHighlightsCardViewModel]>) {
        self._cardsViewModels = cardsViewModels
        self.sectionTitle = sectionTitle
    }
    
}
