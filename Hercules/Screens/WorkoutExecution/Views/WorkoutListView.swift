//
//  WorkoutListView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 27/07/21.
//

import SwiftUI

struct WorkoutListView: View {
    
    @Binding var workout: Workout
    @Binding var isPresenting: Bool
    
    var body: some View {
        NavigationView {
            MainView(background: Color.backgroundColor) {
                List {
                    ForEach(workout.exercises.indices, id: \.self) { index in
                        ExerciseCreationCell(viewModel: .init(data: workout.exercises[index]))
                    }
                    .onMove(perform: { indices, newOffset in
                        workout.exercises.move(fromOffsets: indices, toOffset: newOffset)
                    })
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Edit exercises")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {isPresenting = false}, label: {
                        Text("Done")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView(workout: .constant(Workout()), isPresenting: .constant(false))
            .preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier: "pt_BR"))
    }
}
