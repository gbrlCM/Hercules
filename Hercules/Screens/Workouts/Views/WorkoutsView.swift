//
//  WorkoutsView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct WorkoutsView: View {
    
    @State
    var isCreatingUser: Bool = false
    
    @FetchRequest(fetchRequest: ADWorkout.allWorkouts)
    var workouts: FetchedResults<ADWorkout>

    @ObservedObject
    var viewModel: WorkoutsViewModel = WorkoutsViewModel()
    
    var body: some View {
        NavigationView {
            MainView(background: Color.backgroundColor) {
                if workouts.isEmpty {
                    noWorkouts
                } else {
                    workoutsList
                }
            }
            .navigationTitle("Workouts")
            .sheet(isPresented: $isCreatingUser, content: {
                WorkoutCreationView(presentationBinding: $isCreatingUser)
                    .environment(\.managedObjectContext, viewModel.storage.context)
            })
            .navigationBarItems(trailing: addButton)
        }
    }
    
    @ViewBuilder
    var addButton: some View {
        Button(action: { isCreatingUser = true }, label: {
            Image(systemName: "plus")
                .foregroundColor(.redGradientStart)
        })
    }
    
    @ViewBuilder
    var noWorkouts: some View {
        VStack {
            Text("There is no workouts yet, but you can create one tapping the button bellow!")
            Button {
                isCreatingUser = true
            } label: {
                Label(
                    title: { Text(LocalizedStringKey(.addWorkout)) },
                    icon: { Image(systemName: "plus") }
                )
                .foregroundColor(.redGradientStart)
                .font(.title3.bold())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Capsule().fill(Color.redGradientStart.opacity(0.25)))
        }
    }
    
    @ViewBuilder
    var workoutsList: some View {
        List(workouts) { workout in
            VStack {
                HStack {
                    Text("\(workout.name ?? "nil") - \(workout.exercises?.count ?? 0) exercises")
                    Spacer()
                }
            }
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutsView()
                .environment(\.locale, .init(identifier: "pt_BR"))
            WorkoutsView()
                .preferredColorScheme(.dark)
        }
    }
}
