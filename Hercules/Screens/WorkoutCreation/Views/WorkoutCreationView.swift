//
//  WorkoutsCreation.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI
import UIKit
import SwiftUINavigation

struct WorkoutCreationView: View {
    
    @ObservedObject
    var viewModel: WorkoutCreationViewModel
    
    enum Field: Hashable {
        case name
    }
    
    @FocusState
    var focus: Field?
    
    var body: some View {
        NavigationStack {
            MainView(background: Color.backgroundColor) {
                VStack {
                    DaysSection(isSelected: $viewModel.daysSelected)
                    Form {
                        generalSection
                        exercisesSection
                    }
                }
            }
            .accentColor(.redGradientStart)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                        .accentColor(.redGradientStart)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
            .navigationTitle("Create Workout")
        }
        .accentColor(.redGradientStart)
        .sheet(
            unwrapping: $viewModel.destination,
            case: /WorkoutCreationViewModel.Destination.exerciseList
        ) { $model in
            ExercisesListView(model: model)
        }
    }
    
    @ViewBuilder
    var generalSection: some View {
        Section(header: Text("General")) {
            HStack {
                Text("Name")
                TextField("Workout name...", text: $viewModel.nameField)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($focus, equals: .name)
            }
            Picker("Area of focus", selection: $viewModel.areaOfFocus) {
                ForEach(viewModel.areasOfFocus, id: \.rawValue) { area in
                    Text(area.name)
                }
            }
            DatePicker("End date", selection: $viewModel.endDate, displayedComponents: .date)
                .accentColor(.red)
        }
    }
    
    @ViewBuilder
    var exercisesSection: some View {
        Section {
            List {
                ForEach(viewModel.createdExercises, id: \.hashValue) { exercise in
                    ExerciseCreationCell(viewModel: .init(data: exercise))
                }
                .onDelete { indexSet in
                    viewModel.deleteExercise(at: indexSet)
                }
                .onMove { indices, newOffset in
                    viewModel.moveExercise(fromOffsets: indices, to: newOffset)
                }
            }
            Button {
                viewModel.addExerciseButtonTapped()
            } label: {
                Label("Add Exercise", systemImage: "plus.circle")
            }
        } header: {
            HStack {
                Text("Exercises")
                Spacer()
                EditButton()
                    .accentColor(.redGradientStart)
            }
        }
    }
    
    @ViewBuilder
    var cancelButton: some View {
        Button {
            viewModel.dismissCreation()
        } label: {
            Text("Cancel")
        }
        .foregroundColor(.redGradientStart)
    }
    
    @ViewBuilder
    var saveButton: some View {
        Button {
            viewModel.saveWorkout()
        } label: {
            Text("Save")
                .fontWeight(viewModel.isStillCreating ? .regular : .bold)
        }
        .disabled(viewModel.isStillCreating)
        .foregroundColor(viewModel.isStillCreating ? .gray : .redGradientStart)
    }
}

struct WorkoutsCreation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutCreationView(viewModel: .init())
                .environment(\.locale, .init(identifier: "pt_BR"))
            WorkoutCreationView( viewModel: .init())
                .preferredColorScheme(.dark)
        }
    }
}
