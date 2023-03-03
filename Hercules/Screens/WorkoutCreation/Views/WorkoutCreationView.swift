//
//  WorkoutsCreation.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI
import UIKit

struct WorkoutCreationView: View {
    
    @ObservedObject
    var viewModel: WorkoutCreationViewModel
    
    enum Field: Hashable {
        case name
    }
    
    @FocusState
    var focus: Field?
    
    var body: some View {
        NavigationView {
            MainView(background: Color.backgroundColor) {
                VStack {
                    DaysSection(isSelected: $viewModel.daysSelected)
                    Form {
                        generalSection
                        exercisesSection
                    }.sheet(isPresented: $viewModel.creatingNewItem,
                            content: {
                                ExercisesListView(isCreatingExercise: $viewModel.creatingNewItem)
                                    .environmentObject(viewModel.exerciseCreationController)
                            })
                }
            }
            .accentColor(.redGradientStart)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                        .accentColor(.redGradientStart)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .accentColor(.redGradientStart)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
            .navigationTitle("Create Workout")
        }.accentColor(.redGradientStart)
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
        Section(header: Text("Exercises")) {
            List {
                ForEach(viewModel.createdExercises, id: \.hashValue) { exercise in
                    ExerciseCreationCell(viewModel: .init(data: exercise))
                }
                .onDelete(perform: { indexSet in
                    viewModel.createdExercises.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    viewModel.createdExercises.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            Button(action: {
                viewModel.creatingNewItem = true
            }, label: {
                Label("Add Exercise", systemImage: "plus.circle")
            })
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
            viewModel.dismissCreation()
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
