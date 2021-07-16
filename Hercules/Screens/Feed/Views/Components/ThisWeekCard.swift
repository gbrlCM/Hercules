//
//  ThisWeekCard.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct ThisWeekCard: View {
    
    var viewModel: ThisWeekCardViewModel
    //width: 280, height: 150
    var body: some View {
        Card(size: CGSize(width: 280, height: 150), background: cardBackground ) {
            cardText(viewModel.exerciseDate, font: .title.bold())
            cardText(viewModel.exerciseName, font: .title3)
        }
    }
    
    @ViewBuilder
    var cardBackground: some View {
        GradientBackground(start: .redGradientStart, finish: .redGradientFinish)
    }
    
    @ViewBuilder
    func cardText(_ text: String, font: Font) -> some View {
        Text(text)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 40, alignment: .leading)
            .font(font)
            .foregroundColor(.white)
            .padding(.leading, 8)
    }
}

struct ThisWeekCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThisWeekCard(viewModel: .init(name: "Leg - 8 exercises", dateString: "Today"))
                .previewDevice("iPhone 12")
            ThisWeekCard(viewModel: .init(name: "Leg - 8 exercises", dateString: "Today"))
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 12")
        }
    }
}
