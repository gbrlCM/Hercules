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
        .accentColor(.redGradientStart)
        .navigationTitle(Text(LocalizedStringKey(viewModel.workout.name)))
    }
    
    @ViewBuilder
    var infoSection: some View {
        WorkoutDaysSection(daysOfTheWeek: viewModel.workout.daysOfTheWeek)
        HStack(alignment: .top) {
            WorkoutInfo(title: LocalizedStringKey("area of focus"),
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
                ForEach(0..<viewModel.workout.exercises.count) { index in
                    ExerciseCreationCell(viewModel: .init(data: viewModel.workout.exercises[index]))
                    Divider()
                }
            }
        })
    }
    
    @ViewBuilder
    var actionSection: some View {
        HStack(spacing: 32) {
            WorkoutActionButton(action: {}, color: .redGradientFinish, label: Label(
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
            WorkoutView(viewModel: WorkoutViewModel())
        }
    }
}

struct WorkoutActionButton: View {
    var action: () -> Void
    var color: Color
    var label: Label<Text, Image>
    
    var body: some View {
        Button(action: action, label: {label})
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(width: 120)
            .accentColor(color)
            .background(RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.2)))
    }
}
