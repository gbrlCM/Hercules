//
//  ExerciseEditView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//

import Foundation
import SwiftUI

struct ExercisesEditView: View {
    
    @Binding
    var exercise: Exercise
    
    @Binding
    var isEditingExercise: Bool
    
    init(isEditingExercise: Binding<Bool>, exercise: Binding<Exercise>) {
        self._isEditingExercise = isEditingExercise
        self._exercise = exercise
    }
    
    var body: some View {
            ExerciseList(viewModel: ExercisesListViewModel(storage: ExerciseStorage())) { exercise in
                ExerciseCell(exercise: exercise)
                    .onTapGesture {
                        self.exercise = exercise
                        isEditingExercise = false
                    }
            }.navigationTitle("Exercises")
        
    }
    
}

struct ExercisesEditView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesEditView(isEditingExercise: .constant(true), exercise: .constant(Exercise()))
    }
}
