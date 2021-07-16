//
//  GradientBackground.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct GradientBackground: View {
    
    var start: Color
    var finish: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [start, finish]),
                       startPoint: .bottomTrailing,
                       endPoint: .topLeading )
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground(start: .red, finish: .orange)
    }
}
