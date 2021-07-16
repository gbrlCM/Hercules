//
//  ThisWeekSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct ThisWeekSection: View {
    
    var viewModel: ThisWeekSectionViewModel
    
    var body: some View {
        HorizontalSection(viewModel: viewModel) { index in
            ThisWeekCard(viewModel: viewModel.cardViewModels[index])
        }
    }
    
}

struct ThisWeekSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ThisWeekSectionViewModel()
        ThisWeekSection( viewModel: viewModel)
    }
}
