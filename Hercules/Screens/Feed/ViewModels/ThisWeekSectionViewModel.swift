//
//  ThisWeekSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct ThisWeekSectionViewModel: HorizontalSectionViewModel {
    
    var elementCount: Int
    var sectionTitle: StringKey
    var errorMessage: StringKey
    let cardViewModels: [ThisWeekCardViewModel]
    
    init() {
        cardViewModels = Array.init(repeating: ThisWeekCardViewModel(), count: 7)
        elementCount = cardViewModels.count
        sectionTitle = .thisWeek
        errorMessage = .thisWeekEmpty
    }
    
    init(cardViewModels: [ThisWeekCardViewModel]) {
        self.cardViewModels = cardViewModels
        self.elementCount = cardViewModels.count
        self.sectionTitle = .thisWeek
        self.errorMessage = .thisWeekEmpty
    }
}
