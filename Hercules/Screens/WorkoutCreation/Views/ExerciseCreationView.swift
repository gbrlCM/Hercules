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
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            Form {
                Section(header: Text("Exercise")) {
                    Button {
                        viewModel.selectExerciseButtonTapped()
                    } label: {
                        HStack {
                            Text(
                                LocalizedStringKey(viewModel.exercise.name)
                            )
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Section(header: Text("Quantity")) {
                    Stepper("Series \(viewModel.series)", value: $viewModel.series, in: 1...100)
                    
                    if viewModel.intesityMetric != .areaOfRm && viewModel.intesityMetric != .seconds {
                        HStack {
                            Text("Repetitions")
                            TextField("12", text: $viewModel.repsString)
                                .keyboardType(.decimalPad)
                        }
                    }
            
                }
                
                Section(header: Text("Intensity")) {
                    Picker("Measurement", selection: $viewModel.measurementIndex) {
                        ForEach(
                            viewModel.measurementStyles.indices,
                            id: \.self
                        ) { index in
                            Text(LocalizedStringKey(viewModel.measurementStyles[index].name))
                        }
                    }
                    
                    if viewModel.intesityMetric != .bodyWeight {
                        HStack {
                            Text("Value")
                            TextField("80", text: $viewModel.intesityString)
                                .keyboardType(.decimalPad)
                        }
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
        .animation(.default, value: viewModel.measurementIndex)
        .navigationBarItems(trailing: saveButton)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey(viewModel.exercise.name))
    }
    
    @ViewBuilder
    var saveButton: some View {
        Button {
            viewModel.saveExerciseButtonTapped()
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
        NavigationStack {
            ExerciseCreationView(viewModel: .init(exercise: .init()))
        }
    }
}
