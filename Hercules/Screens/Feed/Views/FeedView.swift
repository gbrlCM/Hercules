//
//  FeedView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct FeedView: View {
    
    @ObservedObject
    var viewModel: FeedViewModel
    @State
    var isCreatingWorkout = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                feed
            }
            .sheet(isPresented: $isCreatingWorkout, content: {
                WorkoutCreationView(presentationBinding: $isCreatingWorkout, viewModel: WorkoutCreationViewModel())
            })
            .navigationTitle("Feed")
        }
    }
    
    @ViewBuilder
    var feed: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ThisWeekSection(viewModel: ThisWeekSectionViewModel(cardViewModels: $viewModel.thisWeekCardViewModel), isCreatingWorkout: $isCreatingWorkout)
            HorizontalSection(viewModel: HorizontalSectionViewModel(sectionTitle: .statsHighlights, cards: $viewModel.activityRing)) {
                Text("There is no stats yet, allow Health so you can see you rings")
            } content: { index in
                ActivityRingCard(actityRingData: $viewModel.activityRing[index])
            }
            PreviousWorkoutsSection(viewModel: .init())
        }
        .listStyle(PlainListStyle())
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedView(viewModel: .init(dataStorage: .init(), healthStorage: .init()))
                .environment(\.locale, .init(identifier: "pt_BR"))
            FeedView(viewModel: .init(dataStorage: .init(), healthStorage: .init()))
                .preferredColorScheme(.dark)
        }
    }
}
