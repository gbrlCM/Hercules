//
//  FeedView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI
import SwiftUINavigation
import Habitat

struct FeedView: View {
    
    @ObservedObject
    var viewModel: FeedViewModel
    
    var body: some View {
        NavigationStack {
            MainView(background: Color.backgroundColor) {
                feed
            }
            .onAppear {
                viewModel.isOnForeground = true
            }
            .onDisappear {
                viewModel.isOnForeground = false
            }
            .sheet(
                unwrapping: $viewModel.destination,
                case: /FeedViewModel.Destination.createWorkout
            ) { $creationModel in
                    WorkoutCreationView(viewModel: creationModel)
            }
            .sheet(
                unwrapping: $viewModel.destination,
                case: /FeedViewModel.Destination.previousSessionSummary
            ) { $summary in
                WorkoutSummaryView(model: summary)
            }
            .navigationDestination(
                unwrapping: $viewModel.destination,
                case: /FeedViewModel.Destination.workoutDetail)
            { $workoutModel in
                WorkoutView(viewModel: workoutModel)
            }
            .environmentObject(viewModel)
            .navigationTitle("Feed")
        }
    }
    
    @ViewBuilder
    var feed: some View {
        ScrollView {
            ThisWeekSection()
            StatHighlightSection(viewModel: .init(sectionTitle: .statsHighlights, cardsViewModels: $viewModel.workoutStatCardViewModels, activityRingData: $viewModel.activityRing))
            PreviousWorkoutsSection()
                .padding(.horizontal)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HabitatPreview {
                FeedView(viewModel: .init())
                    .environment(\.locale, .init(identifier: "pt_BR"))
            } setupEnvirontment: {
                Habitat[\.workoutsStorage] = WorkoutsStorageMock()
                Habitat[\.healthStorage] = HealthStorageMock()
                Habitat[\.dateHelper] = DatesHelperMock()
                    
            }
            HabitatPreview {
                FeedView(viewModel: .init())
                    .preferredColorScheme(.dark)
            } setupEnvirontment: {
                Habitat[\.workoutsStorage] = WorkoutsStorageMock()
                Habitat[\.healthStorage] = HealthStorageMock()
                Habitat[\.dateHelper] = DatesHelperMock()
                    
            }
        }
    }
}
