//
//  ExerciseCell.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//

import SwiftUI

struct ExerciseCell: View {
    
    let exercise: Exercise
    
    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey(exercise.name))
                    .font(.title3)
                Spacer()
            }.padding(.horizontal, 16)
            HStack {
                ForEach(exercise.tags, id: \.name) { tag in
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(tag.name))
                            .font(.subheadline.bold())
                            .foregroundColor(tag.color)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Capsule().stroke(tag.color))
                }
                Spacer()
            }.padding(.horizontal, 16)
        }
    }
}
