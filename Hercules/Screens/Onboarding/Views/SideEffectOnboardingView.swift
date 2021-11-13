//
//  SideEffectOnboardingView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 13/11/21.
//

import SwiftUI

struct SideEffectOnboardingView: View {
    @ObservedObject
    var viewModel: SideEffectOnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            OnboardingChatBalloon(title: viewModel.title,
                                  content: viewModel.text)
                .padding()
            viewModel.image
                .padding(.top, 32)
            Spacer()
            OnboardingButtonSection(leftButtonTitle: .init("Nope"),
                                    leftButtonAction: viewModel.skip,
                                    rightButtonTitle: .init("Allow"),
                                    rightButtonAction: viewModel.next)
        }
    }
}

struct SideEffectOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SideEffectOnboardingView(viewModel: .init(page: .constant(.greetingForWorkout),
                                                  title: .init("Notifications"),
                                                  text: .init("Please allow your notifications, so we can warn you when your rest time is over!"),
                                                  image: Image("NotificationWarning"),
                                                  {}))
    }
}
