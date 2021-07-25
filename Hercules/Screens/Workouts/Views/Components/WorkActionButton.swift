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
    var label: Label<Text, Image>
    
    var body: some View {
        Button(action: action, label: {label})
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(width: 120)
            .accentColor(color)
            .background(RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.2)))
    }
}
