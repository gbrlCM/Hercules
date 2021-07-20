//
//  WorkoutsCreation.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI

struct WorkoutCreationView: View {
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    @Binding
    var presentationBinding: Bool
    
    @ObservedObject
    var viewModel = WorkoutCreationViewModel()
    
    var body: some View {
        NavigationView {
            MainView(background: Color.backgroundColor) {
                VStack {
                    DaysSection(isSelected: $viewModel.daysSelected)
                    Form {
                        generalSection
                        exercisesSection
                    }.sheet(isPresented: $viewModel.creatingNewItem, content: {
                        ExercisesListView()
                            .environmentObject(viewModel)
                            .environment(\.managedObjectContext, viewContext)
                    })
                }
            }
            .accentColor(.redGradientStart)
            .navigationBarItems(leading: cancelButton,trailing: saveButton)
            .navigationTitle("Create Workout")
        }
    }
    
    
    
    @ViewBuilder
    var generalSection: some View {
        Section(header: Text("General")) {
            HStack {
                Text("Name")
                TextField("Workout name...", text: $viewModel.nameField)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            Picker("Area of focus", selection: $viewModel.areaOfFocus) {
                ForEach(viewModel.areasOfFocus, id: \.rawValue) { area in
                    Text(area.name)
                }
            }
            DatePicker("End date", selection: $viewModel.endDate, displayedComponents: .date)
        }
    }
    
    @ViewBuilder
    var exercisesSection: some View {
        Section(header: Text("Exercises")) {
            List(viewModel.createdExercises, id: \.hashValue) { exercise in
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        ExerciseCreationCell(viewModel: .init(data: exercise))
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
            presentationBinding = false
        } label: {
            Text("Cancel")
        }
        .foregroundColor(.redGradientStart)
    }
    
    @ViewBuilder
    var saveButton: some View {
        Button {
            viewModel.saveWorkout()
            presentationBinding = false
        } label: {
            Text("Save")
                .fontWeight(.bold)
        }
        .foregroundColor(.redGradientStart)
    }
}

struct WorkoutsCreation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutCreationView(presentationBinding: .constant(true))
                .environment(\.locale, .init(identifier: "pt_BR"))
            WorkoutCreationView(presentationBinding: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}
