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
    
    let colors: [Color] = [.red, .blue, .green, .yellow, .pink, .purple, .orange]
    
    var body: some View {
        NavigationView {
            VStack {
                tagsSection
                List(viewModel.defaultExercises) { exercise in
                    NavigationLink(
                        destination: Text("oooi"),
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
                            .foregroundColor(colors[index%colors.count])
                    })
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(tagBackground(for: viewModel.tags[index], at: index))
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
                }
            }.padding(.vertical, 12)
        }).padding(.leading, 16)
        
    }
    
    @ViewBuilder
    func tagBackground(for tag: ExerciseTag, at index: Int) -> some View {
        if(viewModel.selectedTags.contains(tag.name)) {
            Capsule().fill(colors[index%colors.count].opacity(0.25))
            
        }
        else {
            Capsule().fill(Color.white)
        }
    }
    
    @ViewBuilder
    func exerciseCell(of exercise: Exercise) -> some View {
        VStack {
            HStack {
                Text(LocalizedStringKey(exercise.name))
                Spacer()
            }.padding(.horizontal, 16)
            HStack {
                ForEach(exercise.tags, id: \.self) { tag in
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(tag))
                            .foregroundColor(.red)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Capsule().stroke(Color.red))
                }
                Spacer()
            }.padding(.horizontal, 16)
        }
        
    }
}

struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView()
    }
}
