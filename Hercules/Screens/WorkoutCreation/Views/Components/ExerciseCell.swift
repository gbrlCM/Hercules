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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading, spacing: 4) {
                ForEach(exercise.tags, id: \.name) { tag in
                    VStack {
                        VStack {
                            Text(LocalizedStringKey(tag.name))
                                .font(.subheadline.bold())
                                .foregroundColor(tag.color)
                        }
                        .frame(minWidth: 80)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 6)
                        .background(Capsule().stroke(tag.color))
                        .padding(.bottom, 2)
                    }
                }
            }.padding(.horizontal, 16)
        }
    }
}

struct ExerciseCell_Preview: PreviewProvider {
    static var previews: some View {
        ExerciseCell(exercise: Exercise())
    }
}

/*
 ForEach(exercise.tags, id: \.name) { tag in
     VStack {
         Text(LocalizedStringKey(tag.name))
             .font(.subheadline.bold())
             .foregroundColor(tag.color)
     }
     .padding(.vertical, 6)
     .padding(.horizontal, 10)
     .background(Capsule().stroke(tag.color))
 }
 */
