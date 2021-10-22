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
            MainView(background: Color.backgroundColor) {
                feed
            }
            .onAppear {
                viewModel.isOnForeground = true
            }
            .onDisappear {
                viewModel.isOnForeground = false
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
            StatHighlightSection(viewModel: .init(sectionTitle: .statsHighlights, cardsViewModels: $viewModel.workoutStatCardViewModels, activityRingData: $viewModel.activityRing))
            PreviousWorkoutsSection(viewModel: .init(cardsViewModels: viewModel.sessions.map { PreviousWorkoutsCellViewModelFactory.build(workoutSession: $0)}))
        }
        .listStyle(PlainListStyle())
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedView(viewModel: .init(dataStorage: WorkoutsStorageMock(), healthStorage: HealthStorageMock(), dateHelper: DatesHelperMock()))
                .environment(\.locale, .init(identifier: "pt_BR"))
            FeedView(viewModel: .init(dataStorage: WorkoutsStorageMock(), healthStorage: HealthStorageMock(), dateHelper: DatesHelperMock()))
                .preferredColorScheme(.dark)
        }
    }
}
