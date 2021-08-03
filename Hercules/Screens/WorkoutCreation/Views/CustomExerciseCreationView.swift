//
//  CustomExerciseNameCreationView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 02/08/21.
//

import SwiftUI

struct CustomExerciseCreationView: View {
    
    @ObservedObject
    private var viewModel = CustomExerciseCreationViewModel()
    @Binding
    var isPresenting: Bool
    
    var save: (Exercise) -> Void
    
    var body: some View {
        NavigationView {
            MainView(background: Color.backgroundColor) {
                Form {
                    HStack {
                        Text("Name: ")
                        TextField("squat", text: $viewModel.exerciseName)
                    }
                    
                    Section(header: Text("Tags")) {
                        VStack {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: 8) {
                                ForEach(0..<viewModel.allTags.count) { index in
                                    TagButton(tag: viewModel.allTags[index],
                                              isSelected: viewModel
                                                .exerciseTags
                                                .contains(viewModel.allTags[index]))
                                        {}.onTapGesture {
                                            viewModel.toggleTag(of: viewModel.allTags[index])
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .padding(.top, 8)
            }
            .navigationBarItems(
                leading: Button(action: {
                    isPresenting = false
                }, label: {
                Text("Cancel")
                    .font(.body)
            }),
                trailing: Button(action: {
                    save(viewModel.exercise)
                    isPresenting = false
                }, label: {
                    Text("Save")
                        .font(.body.bold())
                }))
            .navigationTitle(Text("Exercise Creation"))
        }
    }
}

struct CustomExerciseNameCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomExerciseCreationView(isPresenting: .constant(true), save: {_ in})
            .environment(\.locale, .init(identifier: "pt_BR"))
    }
}
