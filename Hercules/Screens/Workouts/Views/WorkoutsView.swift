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
    
    @ObservedObject
    var viewModel: WorkoutsViewModel
    
    
    var body: some View {
        NavigationView {
            MainView(background: Color.backgroundColor) {
                if viewModel.workouts.isEmpty {
                    noWorkouts
                } else {
                    workoutsList
                }
            }
            .navigationTitle("Workouts")
            .sheet(isPresented: $isCreatingUser, content: {
                WorkoutCreationView(presentationBinding: $isCreatingUser, viewModel: WorkoutCreationViewModel())
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
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
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
        List {
            ForEach(viewModel.workouts.indices, id: \.self) {index  in
                NavigationLink(
                    destination: WorkoutView(viewModel: WorkoutViewModel(workout: $viewModel.workouts[index])),
                    label: {
                        VStack {
                            HStack {
                                Text("\(viewModel.workouts[index].name) - \(viewModel.workouts[index].exercises.count) exercises")
                                    .font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text(viewModel.dateString(for: viewModel.workouts[index]))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    })
                    .listRowBackground(Color.cardBackgroundBasic)
            }
        }
    }
}


struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutsView(viewModel: .init(dataStorage: .init()))
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier: "pt_BR"))
            WorkoutsView(viewModel: .init(dataStorage: .init()))
                .preferredColorScheme(.dark)
        }
    }
}
