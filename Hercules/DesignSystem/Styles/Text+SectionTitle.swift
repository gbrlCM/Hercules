//
//  View+SectionTitle.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/10/21.
//

import SwiftUI


extension Text {
    
    func withSectionHeaderStyle() -> some View {
        self
            .font(.headline)
            .foregroundColor(.primary)
    }
}
