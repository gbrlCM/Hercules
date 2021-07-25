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
    
    init(isCreatingExercise: Binding<Bool>) {
        self._isCreatingExercise = isCreatingExercise
    }
    
    var body: some View {
        NavigationView {
            ExerciseList(viewModel: ExercisesListViewModel()) { exercise in
                NavigationLink(
                    destination: ExerciseCreationView(exercise: exercise,
                                                      isCreatingExercise: $isCreatingExercise),
                    label: {
                        ExerciseCell(exercise: exercise)
                    })
            }.navigationTitle("Exercises")
        }.accentColor(.redGradientStart)
    }
    
}

struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView(isCreatingExercise: .constant(true))
    }
}
