//
//  WorkActionButton.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/07/21.
//

import Foundation
import SwiftUI

struct WorkoutActionButton: View {
    var action: () -> Void
    var color: Color
    var text: LocalizedStringKey
    var image: Image
    
    var body: some View {
        Button(action: action, label: {
            label
        })
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(width: 100)
            .accentColor(color)
            .background(RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.2)))
    }
    
    @ViewBuilder
    var label: some View {
        VStack(spacing: 4.0) {
            image
            Text(text)
        }
    }
}
