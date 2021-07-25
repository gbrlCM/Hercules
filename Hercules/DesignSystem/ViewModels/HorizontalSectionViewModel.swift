//
//  HorizontalSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

class HorizontalSectionViewModel<T>: ObservableObject {
    var sectionTitle: StringKey
    @Binding
    var cards: [T]
    
    init(sectionTitle: StringKey, cards: Binding<[T]>) {
        self.sectionTitle = sectionTitle
        self._cards = cards
    }
    
}

