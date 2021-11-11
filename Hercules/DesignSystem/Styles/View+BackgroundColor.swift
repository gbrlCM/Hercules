//
//  View+BackgroundColor.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/11/21.
//

import SwiftUI

extension View {
    
    func backgroundColor(_ color: Color) -> some View {
        MainView(background: color, content: { self })
    }
}
