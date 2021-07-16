//
//  ContentView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem { Label(
                title: { Text("Feed") },
                icon: { Image(systemName: "square.grid.2x2.fill") }
            ) }
            WorkoutsView()
                .tabItem { Label(
                    title: { Text("Workouts") },
                    icon: { Image(systemName: "flame.fill") }
) }
        }
        .accentColor(.red)
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
