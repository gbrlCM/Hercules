//
//  StatsHighlightsCard.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct StatsHighlightsCard: View {
    
    var size = CGSize(width: 200, height: 130)
    var viewModel: StatHighlightsCardViewModel
    
    var body: some View {
        Card(size: size, background: cardBackground) {
            cardText(viewModel.stat, font: .largeTitle.bold())
                .foregroundColor(statColor)
            cardText(viewModel.description, font: .subheadline)
        }
    
    }
    
    @ViewBuilder
    var cardBackground: some View {
        Color.cardBackgroundBasic
    }
    
    @ViewBuilder
    func cardText(_ text: String, font: Font) -> some View {
        HStack {
            Text(text)
                .font(font)
                .padding(.leading, 8)
            
            Spacer()
        }
    }
    
    var statColor: Color {
        switch viewModel.status {
        case .improvement: return .green
        case .decrease: return .red
        case .neutral: return Color(UIColor.label)
        }
    }
}

struct StatsHighlightsCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsHighlightsCard(viewModel: .init())
            StatsHighlightsCard(viewModel: .init())
                .preferredColorScheme(.dark)
        }
    }
}
