//
//  ExerciseCreation.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import SwiftUI

struct ExerciseCreationView: View {
    
    @EnvironmentObject
    var creationController: WorkoutExerciseCreationController
    
    @ObservedObject
    var viewModel: ExerciseCreationViewModel
    
    @Binding
    var isCreatingExercise: Bool
    
    init(exercise: Exercise, isCreatingExercise: Binding<Bool>) {
        self.viewModel = ExerciseCreationViewModel(exercise: exercise)
        self._isCreatingExercise = isCreatingExercise
    }
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            Form {
                Section(header: Text("Quantity")) {
                    Stepper("Series \(viewModel.series)", value: $viewModel.series, in: 1...100)
                    HStack {
                        Text("Repetitions")
                        TextField("12", text: $viewModel.repsString)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Intensity")) {
                    Picker("Measurement", selection: $viewModel.measurementIndex) {
                        ForEach(0..<viewModel.measurementStyles.count) { index in
                            Text(LocalizedStringKey(viewModel.measurementStyles[index].name))
                        }
                    }
                    HStack {
                        Text("Value")
                        TextField("80", text: $viewModel.intesityString)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Rest time(segs)")
                        TextField("60", text: $viewModel.restTimeString)
                            .keyboardType(.decimalPad)
                    }
                }
            }
        }
        .accentColor(.redGradientStart)
        .navigationBarItems(trailing: saveButton)
    }
    
    @ViewBuilder
    var saveButton: some View {
        Button {
            let exercise = viewModel.createdExercise
            creationController.emit(exercise: exercise)
            isCreatingExercise = false
        } label: {
            Text("Save")
                .fontWeight(viewModel.isButtonDisabled ? .regular : .bold)
                .foregroundColor(viewModel.isButtonDisabled ? Color.gray : Color.redGradientStart)
        }
        .disabled(viewModel.isButtonDisabled)
    }
}

struct ExerciseCreation_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCreationView(exercise: Exercise(), isCreatingExercise: .constant(false))
    }
}
