//
//  TagButton.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/07/21.
//

import SwiftUI

struct TagButton: View {
    let tag: ExerciseTag
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(LocalizedStringKey(tag.name))
                .fontWeight(.semibold)
                .foregroundColor(tag.color)
        })
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(minWidth: 120, alignment: .center)
        .background(tagBackground(for: tag))
    }
    
    @ViewBuilder
    func tagBackground(for tag: ExerciseTag) -> some View {
        if(isSelected) {
            Capsule().fill(tag.color.opacity(0.25))
                .withCardShadow()
            
        }
        else {
            Capsule().fill(Color.cardBackgroundBasic)
                .withCardShadow()
        }
    }
}
