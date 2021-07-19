//
//  EmptySectionButton.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct EmptySectionButton: View {
    
    var title: StringKey
    var symbolName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {}, label: {
            Label(
                title: {
                    Text(LocalizedStringKey(title))
                        .fontWeight(.semibold)
                },
                icon: {
                    Image(systemName: "plus")
                        .font(.body.bold())
                })
        })
        .accentColor(SectionStyle.accentColor)
        .frame(height: SectionStyle.buttonHeight)
        .padding(.vertical, SectionStyle.buttonVerticalPadding)
        .padding(.horizontal, SectionStyle.buttonHorizontalPadding)
        .background(SectionStyle.buttonBackgroundColor)
        .cornerRadius(SectionStyle.buttonCornerRadius)
    }
}

struct EmptySectionButton_Previews: PreviewProvider {
    static var previews: some View {
        EmptySectionButton(title: .thisWeek, symbolName: "plus") {
            
        }
    }
}
