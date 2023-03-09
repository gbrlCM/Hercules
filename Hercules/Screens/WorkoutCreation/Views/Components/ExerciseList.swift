//
//  ExerciseList.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//

import SwiftUI

struct ExerciseList<Cell: View>: View {
    @ObservedObject
    var viewModel: ExercisesListModel
    @ViewBuilder
    var cell: (_ :Exercise) -> Cell
    
    init(viewModel: ExercisesListModel,
         @ViewBuilder cell: @escaping (_ :Exercise) -> Cell) {
        self.viewModel = viewModel
        self.cell = cell
    }
    
    var body: some View {
        listSection
            .navigationTitle("Exercises")
    }
    
    @ViewBuilder
    var listSection: some View {
        List {
            Section {
                LazyVGrid(columns: [.init(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.tags.indices, id: \.self) { index in
                        TagButton(
                            tag: viewModel.tags[index],
                            isSelected: viewModel.selectedTags.contains(viewModel.tags[index])
                        ) {}.onTapGesture {
                                viewModel.toggleTag(of: viewModel.tags[index])
                            }
                    }
                }
            } header: {
                Text("Tags")
            }
            Section(header: Text("Your Exercises")) {
                ForEach(viewModel.userExercises) { exercise in
                    cell(exercise)
                }
            }
            Section(header: Text("Default exercises")) {
                ForEach(viewModel.defaultExercises) { exercise in
                    cell(exercise)
                }
            }
        }
    }
}


struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExerciseList( viewModel: .init()) { exercise in
                NavigationLink(
                    destination: ExerciseCreationView(viewModel: .init(exercise: .init())).navigationTitle(LocalizedStringKey(exercise.name)),
                    label: {
                        ExerciseCell(exercise: exercise)
                    })
            }
        }
    }
}
