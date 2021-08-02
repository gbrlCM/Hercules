//
//  ExerciseList.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//

import SwiftUI

struct ExerciseList<Cell: View>: View {
    @ObservedObject
    var viewModel: ExercisesListViewModel
    @ViewBuilder
    var cell: (_ :Exercise) -> Cell
    
    init(viewModel: ExercisesListViewModel,
         @ViewBuilder cell: @escaping (_ :Exercise) -> Cell) {
        self.viewModel = viewModel
        self.cell = cell
    }
    
    var body: some View {
        VStack {
            tagsSection
            listSection
        }.navigationTitle("Exercises")
    }
    
    @ViewBuilder
    var tagsSection: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<viewModel.tags.count) { index in
                    TagButton(tag: viewModel.tags[index], isSelected: viewModel.selectedTags.contains(viewModel.tags[index]), action: { viewModel.toggleTag(of: viewModel.tags[index])})
                }
            }.padding(.vertical, 12)
        }).padding(.leading, 16)
    }
    
    @ViewBuilder
    var listSection: some View {
        List(viewModel.defaultExercises) { exercise in
            cell(exercise)
        }.listStyle(PlainListStyle())
    }
}


struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList( viewModel: .init()) { exercise in
            NavigationLink(
                destination: ExerciseCreationView(viewModel: .init(exercise: .init()), isCreatingExercise: .constant(false)).navigationTitle(LocalizedStringKey(exercise.name)),
                label: {
                    ExerciseCell(exercise: exercise)
                })
        }
    }
}
