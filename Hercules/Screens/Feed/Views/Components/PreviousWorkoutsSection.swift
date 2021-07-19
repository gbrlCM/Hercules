//
//  PreviousWorkoutsSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct PreviousWorkoutsSection: View {
    
    var viewModel: PreviousWorkoutSectionViewModel
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(viewModel.sectionTitle))
                .font(.title3.bold())
            Spacer()
        }.padding(.horizontal, 16)
        .padding(.bottom, 8)
        ForEach(0..<viewModel.cardsViewModels.count) { index in
            PreviousWorkoutsCell(viewModel: viewModel.cardsViewModels[index])
        }
    }
}

struct PreviousWorkoutsSection_Previews: PreviewProvider {
    static var previews: some View {
        PreviousWorkoutsSection(viewModel: .init())
    }
}