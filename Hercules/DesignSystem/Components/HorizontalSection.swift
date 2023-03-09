//
//  HorizontalSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct HorizontalSection<Content: View, EmptyContent: View, T: Identifiable>: View {
    
    var sectionTitle: StringKey
    @Binding
    var cards: [T]
    @ViewBuilder let content: ((T) -> Content)
    @ViewBuilder let emptyContent: (() -> EmptyContent)
    
    init(
        sectionTitle: StringKey,
        cards: Binding<[T]>,
        @ViewBuilder emptyContent: @escaping (() -> EmptyContent),
        @ViewBuilder content: @escaping ((T) -> Content))
    {
        self.sectionTitle = sectionTitle
        self._cards = cards
        self.content = content
        self.emptyContent = emptyContent
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey(sectionTitle))
                    .withSectionHeaderStyle()
                    .padding(.leading, 16)
                Spacer()
            }
            
            if cards.count > 0 {
                grid
            } else {
                emptyContent()
            }
            
        }.padding(.vertical, 8)
    }
    
    @ViewBuilder
    var grid: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .top, spacing: 16) {
                ForEach($cards) { $card in
                    content(card)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 16)
        })
    }

}
