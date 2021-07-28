//
//  ThisWeekSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct ThisWeekSection: View {
    
    @ObservedObject
    var viewModel: ThisWeekSectionViewModel
    @Binding
    var isCreatingWorkout: Bool
    
    var body: some View {
        HorizontalSection(viewModel: HorizontalSectionViewModel(sectionTitle: viewModel.sectionTitle, cards: viewModel.$cardViewModels)) {
            VStack {
                Text(LocalizedStringKey(viewModel.errorMessage))
                    .font(.system(size: 14))
                    .lineLimit(10)
                    .padding()
                EmptySectionButton(title: .addWorkout, symbolName: "plus") {
                    isCreatingWorkout = true
                }
            }
        } content: { index in
            NavigationLink(
                destination: WorkoutView(viewModel: WorkoutViewModel(workout: $viewModel.cardViewModels[index].workout)),
                label: {
                    ThisWeekCard(viewModel: viewModel.cardViewModels[index])
                })
        }
    }
    
}

struct ThisWeekSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ThisWeekSectionViewModel()
        ThisWeekSection( viewModel: viewModel, isCreatingWorkout: .constant(true))
    }
}
