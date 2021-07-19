//
//  HorizontalSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct HorizontalSection<Content: View, EmptyContent: View>: View {
    let viewModel: HorizontalSectionViewModel
    @ViewBuilder let content: ((Int) -> Content)
    @ViewBuilder let emptyContent: (() -> EmptyContent)
    
    init(viewModel: HorizontalSectionViewModel,@ViewBuilder emptyContent: @escaping (() -> EmptyContent), @ViewBuilder content: @escaping ((Int) -> Content)) {
        self.viewModel = viewModel
        self.content = content
        self.emptyContent = emptyContent
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey(viewModel.sectionTitle))
                    .font(.title3.bold())
                    .padding(.leading, 16)
                Spacer()
            }
            
            if viewModel.elementCount > 0 {
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
                ForEach(0..<viewModel.elementCount) {index in
                    content(index)
                }
            }
        }).padding(.leading, 16)
    }

}

struct HorizontalSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ThisWeekSectionViewModel(cardViewModels: [
                .init(name: "Leg - 8 exercises", dateString: "Today"),
                .init(name: "Leg - 8 exercises", dateString: "Today"),
                .init(name: "Leg - 8 exercises", dateString: "Today"),
                .init(name: "Leg - 8 exercises", dateString: "Today")
            ])
        
        HorizontalSection(viewModel: viewModel, emptyContent: {}) { index in
            ThisWeekCard(viewModel: viewModel.cardViewModels[index])
        }.environment(\.locale, .init(identifier: "pt_BR"))
    }
}
