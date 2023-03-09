//
//  CustomExerciseNameCreationView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 02/08/21.
//

import SwiftUI

struct CustomExerciseCreationView: View {
    
    @ObservedObject
    var model: CustomExerciseCreationViewModel
    
    var body: some View {
        NavigationStack {
            MainView(background: Color.backgroundColor) {
                Form {
                    HStack {
                        Text("Name: ")
                        TextField("squat", text: $model.exerciseName)
                    }
                    
                    Section(header: Text("Tags")) {
                        VStack {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: 8) {
                                ForEach(model.allTags.indices, id: \.self) { index in
                                    TagButton(
                                        tag: model.allTags[index],
                                        isSelected: model.isTagSelected(model.allTags[index])
                                    ){}
                                    .onTapGesture {
                                        model.toggleTag(at: index)
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
                    model.cancelButtonTapped()
                }, label: {
                Text("Cancel")
                    .font(.body)
            }),
                trailing: Button(action: {
                    model.saveButtonTapped()
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
        CustomExerciseCreationView(model: CustomExerciseCreationViewModel())
            .environment(\.locale, .init(identifier: "pt_BR"))
    }
}
