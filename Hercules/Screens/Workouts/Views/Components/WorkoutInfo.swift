//
//  WorkoutInfo.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/07/21.
//

import Foundation
import SwiftUI

struct WorkoutInfo<Content: View>: View {
    var title: LocalizedStringKey
    var information: Content
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 1)
            information
        }
        .frame(width: 90, height: 90, alignment: .center)
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.tertiarySystemBackground)))
    }
}
