//
//  HorizontalSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct HorizontalSection<Content: View>: View {
    let viewModel: HorizontalSectionViewModel
    @ViewBuilder let content: ((Int) -> Content)
    
    init(viewModel: HorizontalSectionViewModel, @ViewBuilder content: @escaping ((Int) -> Content)) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.sectionTitle)
                    .font(.title3.bold())
                    .padding(.leading, 16)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false, content: {
                gridContent
            })
            .padding(.leading, 16)
        }.padding(.vertical, 8)
    }
    
    @ViewBuilder
    var gridContent: some View {
        HStack(alignment: .top, spacing: 16) {
            if viewModel.elementCount > 0 {
                ForEach(0..<viewModel.elementCount) {index in
                    content(index)
                }
            } else {
                Text(viewModel.emptySectionMessage)
            }
        }
    }

}

struct HorizontalSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ThisWeekSectionViewModel(
            sectionTitle: "This Week",
            emptySectionMessage: "No training scheduled for this week",
            cardViewModels: [
                .init(name: "Leg - 8 exercises", dateString: "Today"),
                .init(name: "Leg - 8 exercises", dateString: "Today"),
                .init(name: "Leg - 8 exercises", dateString: "Today"),
                .init(name: "Leg - 8 exercises", dateString: "Today")
            ])
        
        HorizontalSection(viewModel: viewModel) { index in
            ThisWeekCard(viewModel: viewModel.cardViewModels[index])
        }
    }
}
