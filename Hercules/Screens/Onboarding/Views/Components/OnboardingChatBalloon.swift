//
//  BalloonContent.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 13/11/21.
//

import SwiftUI

struct OnboardingChatBalloon: View {
    var title: LocalizedStringKey
    var content: LocalizedStringKey
    @Environment(\.sizeCategory)
    var sizeCategory
    
    var body: some View {
        ChatBalloon {
            if sizeCategory >= .extraLarge {
                balloonContentForLargeSize
            } else {
                balloonContent
            }
        }
    }
    
    @ViewBuilder
    var balloonContent: some View {
        VStack {
            Text(title)
                .foregroundColor(.redGradientStart)
                .font(.title.bold())
                .padding(.bottom, 2)
            Text(content)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    var balloonContentForLargeSize: some View {
        ScrollView(.vertical, showsIndicators: true) { balloonContent }
    }
}

struct BalloonContent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingChatBalloon(title: .init("Hello"), content: .init("UUUUUH Shanty"))
            .padding()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
