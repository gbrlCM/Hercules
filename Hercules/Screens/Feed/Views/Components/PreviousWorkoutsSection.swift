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
        
        if viewModel.cardsViewModels.isEmpty {
            Text("There is no workout finished yet!")
                .font(.system(size: 14))
            
        } else {
            LazyVStack {
                ForEach(viewModel.cardsViewModels.indices, id: \.self) { index in
                    PreviousWorkoutsCell(viewModel: viewModel.cardsViewModels[index])
                }
            }
        }
    }
}

struct PreviousWorkoutsSection_Previews: PreviewProvider {
    static var previews: some View {
        PreviousWorkoutsSection(viewModel: .init())
    }
}
