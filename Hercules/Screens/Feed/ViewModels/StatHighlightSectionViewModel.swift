//
//  StatHighlightSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

class StatHighlightSectionViewModel: ObservableObject {
    
    var sectionTitle: StringKey
    
    @Binding
    var cardsViewModels: [StatHighlightsCardViewModel]
    
    @Binding
    var activityRingsViewModels: [ActivityRingData]
    
    init() {
        _cardsViewModels = .constant(Array(repeating: StatHighlightsCardViewModel(), count: 4))
        _activityRingsViewModels = .constant(Array(repeating: ActivityRingData(name: .calories, achieved: 500, goal: 550), count: 3))
        sectionTitle = .statsHighlights
    }
    
    init(sectionTitle: StringKey, cardsViewModels: Binding<[StatHighlightsCardViewModel]>, activityRingData: Binding<[ActivityRingData]>) {
        self._cardsViewModels = cardsViewModels
        self._activityRingsViewModels = activityRingData
        self.sectionTitle = sectionTitle
    }
    
}
