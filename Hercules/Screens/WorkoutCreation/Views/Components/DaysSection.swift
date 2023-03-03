//
//  DaysSections.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI

struct DaysSection: View {
    
    @Binding var isSelected: [Bool]
    
    var viewModel = DaysSectionViewModel()
    
    var body: some View {
        HorizontalSection(sectionTitle: viewModel.sectionTitle, cards: .constant(viewModel.days), emptyContent: { EmptyView() }) { day in
            DayButton(day: day, isSelected: $isSelected[day.rawValue - 1])
        }
    }
}

struct DaysSections_Previews: PreviewProvider {
    static var previews: some View {
        let days = Day.allCases
        let isSelected = days.map {_ in Bool.random() }
        DaysSection(isSelected: .constant(isSelected))
    }
}
