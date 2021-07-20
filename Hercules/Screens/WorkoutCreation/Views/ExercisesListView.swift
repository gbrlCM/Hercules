//
//  ExercisesListView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI
//"ExerciseCreationView(exercise: exercise).navigationTitle(Text(LocalizedStringKey(exercise.name ?? "")))"

struct ExercisesListView: View {
    
    @ObservedObject
    var viewModel: ExercisesListViewModel = ExercisesListViewModel()
    
    @EnvironmentObject
    var workoutViewModel: WorkoutCreationViewModel
    
    @Binding
    var isCreatingExercise: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                tagsSection
                List(viewModel.defaultExercises) { exercise in
                    NavigationLink(
                        destination: ExerciseCreationView(exercise: exercise, isCreatingExercise: $isCreatingExercise),
                        label: {
                            exerciseCell(of: exercise)
                        })
                }.listStyle(PlainListStyle())
            }.navigationTitle("Exercises")
        }.accentColor(.redGradientStart)
    }
    
    @ViewBuilder
    var tagsSection: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<viewModel.tags.count) { index in
                    Button(action: {
                        viewModel.toggleTag(of: viewModel.tags[index])
                    }, label: {
                        Text(LocalizedStringKey(viewModel.tags[index].name))
                            .fontWeight(.semibold)
                            .foregroundColor(viewModel.tags[index].color)
                    })
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(tagBackground(for: viewModel.tags[index], at: index))
                }
            }.padding(.vertical, 12)
        }).padding(.leading, 16)
        
    }
    
    @ViewBuilder
    func tagBackground(for tag: ExerciseTag, at index: Int) -> some View {
        if(viewModel.selectedTags.contains(tag.name)) {
            Capsule().fill(tag.color.opacity(0.25))
                .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
            
        }
        else {
            Capsule().fill(Color.white)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
        }
    }
    
    @ViewBuilder
    func exerciseCell(of exercise: Exercise) -> some View {
        VStack {
            HStack {
                Text(LocalizedStringKey(exercise.name))
                    .font(.title3)
                Spacer()
            }.padding(.horizontal, 16)
            HStack {
                ForEach(exercise.tags, id: \.self) { tag in
                    let color = viewModel.colorForTag(named: tag)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(tag))
                            .font(.subheadline.bold())
                            .foregroundColor(color)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Capsule().stroke(color))
                }
                Spacer()
            }.padding(.horizontal, 16)
        }
        
    }
}

struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView(isCreatingExercise: .constant(true))
    }
}
