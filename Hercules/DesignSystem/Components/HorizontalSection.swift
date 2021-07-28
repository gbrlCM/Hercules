//
//  HorizontalSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct HorizontalSection<Content: View, EmptyContent: View, T>: View {
    
    @ObservedObject
    var viewModel: HorizontalSectionViewModel<T>
    @ViewBuilder let content: ((Int) -> Content)
    @ViewBuilder let emptyContent: (() -> EmptyContent)
    
    init(viewModel: HorizontalSectionViewModel<T>, @ViewBuilder emptyContent: @escaping (() -> EmptyContent), @ViewBuilder content: @escaping ((Int) -> Content)) {
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
            
            if viewModel.cards.count > 0 {
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
                ForEach(viewModel.cards.indices, id: \.self) {index in
                    content(index)
                        .padding(.vertical, 12)
                }
            }
        })
        .padding(.leading, 16)
    }

}

struct HorizontalSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HorizontalSectionViewModel(sectionTitle: .thisWeek, cards: .constant([
            ThisWeekCardViewModel(name: "Leg - 8 exercises", dateString: "Today", workout: Workout()),
            ThisWeekCardViewModel(name: "Leg - 8 exercises", dateString: "Today", workout: Workout()),
            ThisWeekCardViewModel(name: "Leg - 8 exercises", dateString: "Today", workout: Workout()),
            ThisWeekCardViewModel(name: "Leg - 8 exercises", dateString: "Today", workout: Workout())
        ]))
        
        HorizontalSection(viewModel: viewModel, emptyContent: {}) { index in
            ThisWeekCard(viewModel: viewModel.cards[index])
        }.environment(\.locale, .init(identifier: "pt_BR"))
    }
}
