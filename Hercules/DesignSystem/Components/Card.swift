//
//  Card.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct Card<Content: View, Background: View>: View {
    
    var size: CGSize
    var content: Content
    var background: Background
    
    init(size: CGSize, background: Background, @ViewBuilder content: () -> Content) {
        self.size = size
        self.background = background
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(width: size.width,
               height: size.height,
               alignment: .leading
        )
        .background(background)
        .cornerRadius(16)
        .withCardShadow()
    }
}

struct CardBackground_Previews: PreviewProvider {
    static var previews: some View {
        Card(size: .init(width: 270, height: 150), background: GradientBackground(start: .red, finish: .orange), content: {EmptyView()})
    }
}
