//
//  ContentView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI
import Habitat
import SwiftUINavigation

final class AppModel: ObservableObject {
    enum Destination {
        case feed
        case workouts
    }
    
    @Published var destination: Destination
    
    let feedModel: FeedViewModel
    let workoutsModel: WorkoutsViewModel
    
    init(
        destination: Destination = .feed,
        feedModel: FeedViewModel = FeedViewModel(),
        workoutModel: WorkoutsViewModel = WorkoutsViewModel()
    ) {
        self.destination = destination
        self.feedModel = feedModel
        self.workoutsModel = workoutModel
    }
}

struct ContentView: View {
    
    @ObservedObject
    var model: AppModel
    
    @Dependency(\.workoutsStorage)
    var workoutStorage: WorkoutsStorage
    let healthStorage: HealthStorage = HealthStorageImpl()
    
    var body: some View {
        TabView(selection: $model.destination) {
            FeedView(viewModel: model.feedModel)
                .tabItem { Label(
                    title: { Text("Feed") },
                    icon: { Image(systemName: "square.grid.2x2.fill") }
                ) }
                .tag(AppModel.Destination.feed)
            WorkoutsView(viewModel: model.workoutsModel)
                .tabItem { Label(
                    title: { Text("Workouts") },
                    icon: { Image(systemName: "flame.fill") }
                ) }
                .tag(AppModel.Destination.workouts)
        }.onAppear {
            UserNotificationManager.shared.requestAuthorization()
        }
        .accentColor(.red)
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HabitatPreview {
            ContentView(model: AppModel(destination: .feed))
                .environment(\.locale, .init(identifier: "pt_BR"))
        } setupEnvirontment: {
            Habitat[\.workoutsStorage] = WorkoutsStorageMock()
            Habitat[\.healthStorage] = HealthStorageMock()
            Habitat[\.dateHelper] = DatesHelperMock()
                
        }
    }
}
