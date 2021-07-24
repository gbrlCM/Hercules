//
//  ThisWeekSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

class ThisWeekSectionViewModel: ObservableObject {
    
    var sectionTitle: StringKey
    var errorMessage: StringKey
    
    @Binding
    var cardViewModels: [ThisWeekCardViewModel]
    
    init() {
        _cardViewModels = .constant(Array.init(repeating: ThisWeekCardViewModel(), count: 7))
        sectionTitle = .thisWeek
        errorMessage = .thisWeekEmpty
    }
    
    init(cardViewModels: Binding<[ThisWeekCardViewModel]>) {
        self._cardViewModels = cardViewModels
        self.sectionTitle = .thisWeek
        self.errorMessage = .thisWeekEmpty
    }
}
