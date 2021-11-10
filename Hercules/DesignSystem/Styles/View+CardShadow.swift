//
//  View+CardShadow.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/10/21.
//

import SwiftUI

extension View {
    
    func withCardShadow() -> some View {
        self
            .shadow(color: .black.opacity(0.15), radius: 2, x: 2, y: 2)
    }
}
