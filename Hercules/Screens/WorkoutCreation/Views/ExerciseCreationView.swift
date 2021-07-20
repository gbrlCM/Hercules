//
//  ExerciseCreation.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import SwiftUI

struct ExerciseCreationView: View {
    
    var exercise: ADExercise
    
    @EnvironmentObject
    var workoutViewModel: WorkoutCreationViewModel
    
    @State
    var series: Int = 1
    
    @State
    var repsString: String = ""
    
    @State
    var measurementIndex: Int = 0
    
    @State
    var restTimeString: String = ""
    
    @State
    var intesityString: String = ""
    
    var measurementStyles = IntensityType.allCases
    
    var reps: Int {
        guard let number = NumberFormatter().number(from: repsString)?.intValue else {
            return 0
        }
        
        return number
    }
    
    var intesity: Double {
        guard let number = NumberFormatter().number(from: repsString)?.doubleValue else {
            return 0
        }
        
        return number
    }
    
    var restTime: Double {
        guard let number = NumberFormatter().number(from: restTimeString)?.doubleValue else {
            return 0
        }
        
        return number
    }
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            Form {
                Section(header: Text("Quantity")) {
                    Stepper("Series \(series)", value: $series, in: 1...100)
                    HStack {
                        Text("Repetitions")
                        TextField("12", text: $repsString)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Intensity")) {
                    Picker("Measurement", selection: $measurementIndex) {
                        ForEach(0..<measurementStyles.count) { index in
                            Text(LocalizedStringKey(measurementStyles[index].name))
                        }
                    }
                    HStack {
                        Text("Value")
                        TextField("80", text: $intesityString)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Rest time(segs)")
                        TextField("60", text: $restTimeString)
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
            //workoutViewModel.saveExercise(WorkoutExercise)
        } label: {
            Text("Save")
                .fontWeight(.bold)
                .foregroundColor(.redGradientStart)
        }
    }
}

struct ExerciseCreation_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCreationView(exercise: ADExercise())
    }
}
