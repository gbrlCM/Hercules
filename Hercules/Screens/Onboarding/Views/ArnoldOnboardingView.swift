//
//  ArnoldOnboardingView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/11/21.
//

import SwiftUI

struct ArnoldOnboardingView: View {
    @ObservedObject
    var viewModel: ArnoldOnboardingViewModel
    @Environment(\.dismiss)
    var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            OnboardingChatBalloon(title: viewModel.title,
                                  content: viewModel.text)
            .padding()
            Image("ArnoldGradient")
                .padding(.top, 32)
            Spacer()
            OnboardingButtonSection(leftButtonTitle: .init("Skip"),
                                    leftButtonAction: { dismiss() },
                                    rightButtonTitle: .init("Next"),
                                    rightButtonAction: viewModel.next)
        }
    }
}

struct ArnoldOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ArnoldOnboardingView(viewModel: .init(page: .constant(.greeting), title: .init("Welcome"), text: .init("I’m here to help you reach your full fitness potential. And how am I gonna do that? 🤔 \n \n I will store your workouts, tell you when your rest time is over and show you your weekly scheadule. \n \n If you want to know more press next!")))
    }
}
