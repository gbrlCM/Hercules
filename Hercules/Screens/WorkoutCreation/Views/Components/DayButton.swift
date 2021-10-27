//
//  DayButton.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI

struct DayButton: View {
    
    var day: Day
    @Binding var isSelected: Bool
    
    let unselectedBackground = Color.cardBackgroundBasic
    let selectedBackground = GradientBackground(start: .redGradientStart, finish: .redGradientFinish)
    
    var body: some View {
        Button { isSelected.toggle() } label: {
            Text(day.letter)
                .font(.system(size: 26))
                .fontWeight(.heavy)
                .foregroundColor(isSelected ? .white : .primary)
        }
        .frame(width: 44, height: 44, alignment: .center)
        .background(background)
        .cornerRadius(22)
        .withCardShadow()
    }
    
    @ViewBuilder
    var background: some View {
        if isSelected {
            selectedBackground
        } else {
            unselectedBackground
        }
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        DayButton(day: .sunday, isSelected: .constant(true))
    }
}
