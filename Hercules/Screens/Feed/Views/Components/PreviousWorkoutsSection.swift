//
//  PreviousWorkoutsSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI
import Habitat

struct PreviousWorkoutsSection: View {
    
    @EnvironmentObject var model: FeedViewModel
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(.previousWorkouts))
                .withSectionHeaderStyle()
            Spacer()
        }.padding(.horizontal, 16)
        .padding(.bottom, 8)
        
        if model.sessions.isEmpty {
            Text("There is no workout finished yet!")
                .font(.system(size: 14))
            
        } else {
                ForEach(model.sessionCards) { card in
                    PreviousWorkoutsCell(viewModel: card) { summary in
                        model.previousWorkoutButtonTapped(summary)
                    }.padding(.bottom, 4)
                }
            
        }
    }
}

struct PreviousWorkoutsSection_Previews: PreviewProvider {
    static var previews: some View {
        HabitatPreview {
            ScrollView {
                LazyVStack {
                    PreviousWorkoutsSection()
                        .environmentObject(FeedViewModel())
                }
            }
        } setupEnvirontment: {
            Habitat[\.workoutsStorage] = WorkoutsStorageMock()
            Habitat[\.healthStorage] = HealthStorageMock()
            Habitat[\.dateHelper] = DatesHelperMock()
                
        }
    }
}
