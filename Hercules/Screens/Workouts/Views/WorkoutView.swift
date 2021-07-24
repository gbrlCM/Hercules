//
//  WorkoutView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import SwiftUI

struct WorkoutView: View {
    
    @ObservedObject
    var viewModel: WorkoutViewModel
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            VStack {
                infoSection
                exerciseSection
                actionSection
            }
        }
        .navigationTitle(Text(LocalizedStringKey(viewModel.workout.name)))
        .accentColor(.redGradientStart)
        .sheet(isPresented: $viewModel.isEditing) {
            WorkoutCreationView(presentationBinding: $viewModel.isEditing, viewModel: WorkoutCreationViewModel(workout: viewModel.workout))
        }
    }
    
    @ViewBuilder
    var infoSection: some View {
        WorkoutDaysSection(daysOfTheWeek: viewModel.workout.daysOfTheWeek)
        HStack(alignment: .top) {
            WorkoutInfo(title: LocalizedStringKey("Area of focus"),
                        information: Text(viewModel.workout.focusArea.name)).font(.title2.bold())
            WorkoutInfo(title: LocalizedStringKey("Scheaduled until"),
                        information: Text(viewModel.endDateFormatted).bold().scaledToFill())
            WorkoutInfo(title: LocalizedStringKey("Number of exercises"),
                        information: Text("\(viewModel.workout.exercises.count)").font(.title2.bold()))
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    var exerciseSection: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            HStack {
                Text("Exercises").font(.title2).bold()
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            LazyVStack {
                ForEach(viewModel.workout.exercises.indices, id: \.self) { index in
                    ExerciseCreationCell(viewModel: .init(data: viewModel.workout.exercises[index]))
                    Divider()
                }
            }
        })
    }
    
    @ViewBuilder
    var actionSection: some View {
        HStack(spacing: 32) {
            WorkoutActionButton(action: {viewModel.isEditing = true}, color: .redGradientFinish, label: Label(
                title: { Text("Edit") },
                icon: { Image(systemName: "pencil") }
            ))
            WorkoutActionButton(action: {}, color: .redGradientStart, label: Label(
                title: { Text("Start") },
                icon: { Image(systemName: "play.fill") }
            ))
        }.padding(.vertical, 16)
        
    }
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutView(viewModel: WorkoutViewModel())
                .previewDevice("iPhone SE (2nd generation)")
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier: "pt_BR"))
            WorkoutView(viewModel: WorkoutViewModel())
        }
    }
}


