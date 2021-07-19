//
//  MainView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI

struct MainView<Content: View, Background: View>: View {
    
    let backgroundView: Background
    let content: Content
    
    init(background: Background, @ViewBuilder content: () -> Content) {
        self.backgroundView = background
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            backgroundView
                .ignoresSafeArea()
            content
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(background: Color.backgroundColor, content: {EmptyView()})
    }
}
