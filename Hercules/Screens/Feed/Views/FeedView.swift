//
//  FeedView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct FeedView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                feed
            }
            .navigationTitle("Feed")
        }
    }
    
    @ViewBuilder
    var feed: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ThisWeekSection(viewModel: .init())
            StatHighlightSection(viewModel: .init())
            PreviousWorkoutsSection(viewModel: .init())
        }
        .listStyle(PlainListStyle())
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedView()
            FeedView()
                .preferredColorScheme(.dark)
        }
    }
}
