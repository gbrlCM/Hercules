//
//  StatHighlightSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct StatHighlightSection: View {
    
    var viewModel: StatHighlightSectionViewModel
    
    var body: some View {
        HorizontalSection(viewModel: HorizontalSectionViewModel(sectionTitle: viewModel.sectionTitle, cards: viewModel.$cardsViewModels)) {
            
        } content: {index in
            StatsHighlightsCard(viewModel: viewModel.cardsViewModels[index])
                .padding(.bottom, 8)
        }
    }
}

struct StatHighlightSection_Previews: PreviewProvider {
    static var previews: some View {
        StatHighlightSection(viewModel: .init())
    }
}
