//
//  ExercisesListView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct ExercisesListView: View {
    
    @Binding
    var isCreatingExercise: Bool
    @State
    var isCreatingNewExercise: Bool = false
    
    private let storage: ExerciseStorage = ExerciseStorageImpl()
    
    var body: some View {
        NavigationView {
            ExerciseList(viewModel: ExercisesListViewModel(storage: storage)) { exercise in
                NavigationLink(
                    destination: ExerciseCreationView(viewModel: .init(exercise: exercise), isCreatingExercise: $isCreatingExercise),
                    label: {
                        ExerciseCell(exercise: exercise)
                    })
            }
            .sheet(isPresented: $isCreatingNewExercise, content: {
                CustomExerciseCreationView(isPresenting: $isCreatingExercise) { exercise in
                    storage.save(exercise: exercise)
                }
            })
            .navigationBarItems(trailing: Button(action: {
                isCreatingNewExercise = true
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
        ExercisesListView(isCreatingExercise: .constant(true))
    }
}
