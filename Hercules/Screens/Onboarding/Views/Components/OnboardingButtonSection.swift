//
//  OnboardingButtonSection.swift.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 13/11/21.
//

import SwiftUI

struct OnboardingButtonSection: View {
    var leftButtonTitle: LocalizedStringKey
    var leftButtonAction: () -> Void
    var rightButtonTitle: LocalizedStringKey
    var rightButtonAction: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            button(leftButtonTitle, leftButtonAction)
            Spacer()
            button(rightButtonTitle, rightButtonAction)
            Spacer()
        }.padding()
    }
    
    @ViewBuilder
    func button(_ text: LocalizedStringKey, _ action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            Text(text)
                .font(.system(size: 18))
                .padding(.vertical, 8)
                .padding(.horizontal, 32)
        })
            .buttonStyle(.bordered)
            .tint(.redGradientStart)
    }
}

struct OnboardingButtonSection_swift_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButtonSection(leftButtonTitle: .init("Skip"),
                                leftButtonAction: {},
                                rightButtonTitle: .init("Next"),
                                rightButtonAction: {})
            .previewLayout(.sizeThatFits)
            .environment(\.locale, .init(identifier: "pt-br"))
    }
}
