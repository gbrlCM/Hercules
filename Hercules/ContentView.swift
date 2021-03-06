//
//  ContentView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct ContentView: View {
    
    let workoutStorage: WorkoutsStorage = WorkoutsStorageImpl()
    let healthStorage: HealthStorage = HealthStorageImpl()
    
    var body: some View {
        TabView {
            FeedView(viewModel: .init(dataStorage: workoutStorage, healthStorage: healthStorage))
                .tabItem { Label(
                    title: { Text("Feed") },
                    icon: { Image(systemName: "square.grid.2x2.fill") }
                ) }
            WorkoutsView(viewModel: .init(dataStorage: workoutStorage))
                .tabItem { Label(
                    title: { Text("Workouts") },
                    icon: { Image(systemName: "flame.fill") }
                ) }
        }.onAppear {
            UserNotificationManager.shared.requestAuthorization()
            UITableView.appearance().backgroundColor = UIColor.clear
        }
        .accentColor(.red)
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "pt_BR"))
    }
}
