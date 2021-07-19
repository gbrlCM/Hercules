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
        HorizontalSection(viewModel: viewModel, emptyContent: {}) { index in
            DayButton(day: viewModel.days[index], isSelected: $isSelected[index])
                .padding(.top, 4)
                .padding(.bottom, 12)
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
