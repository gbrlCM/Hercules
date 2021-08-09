//
//  StatHighlightSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct StatHighlightSection: View {
    
    @ObservedObject
    var viewModel: StatHighlightSectionViewModel
    
    var body: some View {
        //        HorizontalSection(viewModel: HorizontalSectionViewModel(sectionTitle: viewModel.sectionTitle, cards: viewModel.$cardsViewModels)) {
        //
        //        } content: {index in
        //            StatsHighlightsCard(viewModel: viewModel.cardsViewModels[index])
        //                .padding(.bottom, 8)
        //        }
        content
    }
    
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading) {
            Text("Stats Highlights")
                .font(.headline)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(viewModel.activityRingsViewModels.indices, id: \.self) { index in
                        ActivityRingCard(actityRingData: $viewModel.activityRingsViewModels[index])
                    }
                    ForEach(viewModel.cardsViewModels.indices, id: \.self) { index in
                        StatsHighlightsCard(viewModel: viewModel.cardsViewModels[index])
                    }
                    
                }.padding(.vertical, 8)
            }
        }.padding(.leading, 16)
    }
}

struct StatHighlightSection_Previews: PreviewProvider {
    static var previews: some View {
        StatHighlightSection(viewModel: .init())
    }
}
