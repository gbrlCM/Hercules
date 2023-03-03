//
//  ThisWeekSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct ThisWeekSection: View {
    
    @EnvironmentObject
    var model: FeedViewModel
    
    var body: some View {
        HorizontalSection(
            sectionTitle: .thisWeek,
            cards: $model.thisWeekCardViewModel) {
                VStack {
                    Text(LocalizedStringKey(.thisWeekEmpty))
                        .font(.system(size: 14))
                        .lineLimit(10)
                        .padding()
                    EmptySectionButton(title: .addWorkout, symbolName: "plus") {
                        model.createWorkoutTapped()
                    }
                }
            } content: { thisWeekModel in
                Button {
                    model.workoutButtonTapped(thisWeekModel.workout)
                } label: {
                    ThisWeekCard(viewModel: thisWeekModel)
                }
            }

        
//        HorizontalSection(viewModel: HorizontalSectionViewModel(sectionTitle: .thisWeek, cards: $model.thisWeekCardViewModel)) {
//            VStack {
//                Text(LocalizedStringKey(.thisWeekEmpty))
//                    .font(.system(size: 14))
//                    .lineLimit(10)
//                    .padding()
//                EmptySectionButton(title: .addWorkout, symbolName: "plus") {
//                    isCreatingWorkout = true
//                }
//            }
//        } content: { index in
//            Button {
//
//            } label: {
//                ThisWeekCard(viewModel: viewModel.cardViewModels[index])
//            }
//        }
    }
    
}

struct ThisWeekSection_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeekSection()
            .environmentObject(FeedViewModel())
    }
}
