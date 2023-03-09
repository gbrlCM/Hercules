//
//  ExercisesListView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI
import Habitat
import SwiftUINavigation

struct ExercisesListView: View {
    
    @ObservedObject
    var model: ExercisesListModel
    
    var body: some View {
        NavigationStack {
            ExerciseList(viewModel: model) { exercise in
                Button {
                    model.exerciseButtonTapped(exercise)
                } label: {
                    ExerciseCell(exercise: exercise)
                }
                .tint(.primary)
            }
            .sheet(
                unwrapping: $model.destination,
                case: /ExercisesListModel.Destination.createCustomExercise
            ) { $model in
                CustomExerciseCreationView(model: model)
            }
            .navigationDestination(
                unwrapping: $model.destination,
                case: /ExercisesListModel.Destination.configureExercise
            ) { $model in
                ExerciseCreationView(viewModel: model)
            }
            .navigationBarItems(trailing: Button(action: {
                model.addExerciseButtonTapped()
            }, label: {
                Image(systemName: "plus")
                .font(.title3)
            }))
            .navigationTitle("Exercises")
        }.accentColor(.redGradientStart)
    }
    
}

struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView(model: ExercisesListModel())
    }
}
