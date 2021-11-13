//
//  OnboardingView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/11/21.
//

import SwiftUI

struct OnboardingView: View {
    @State
    var tag: OnboardingPage = .notification
    
    var body: some View {
        VStack {
            TabView(selection: $tag) {
                ArnoldOnboardingView(viewModel: .init(page: $tag,
                                                      title: .init("Welcome"),
                                                      text: .init("I’m here to help you reach your full fitness potential. And how am I gonna do that? 🤔 \n \n I will store your workouts, tell you when your rest time is over and show you your weekly scheadule. \n \n If you want to know more press next!")))
                    .tag(OnboardingPage.greeting)
                SideEffectOnboardingView(viewModel: .init(page: $tag,
                                                          title: .init("Notifications"),
                                                          text: "Please allow your notifications, so we can warn you when your rest time is over!",
                                                          image: Image("NotificationWarning"),
                                                          UserNotificationManager.shared.requestAuthorization))
                    .tag(OnboardingPage.notification)
                Text("Third")
                    .tag(OnboardingPage.health)
                Text("Fourth")
                    .tag(OnboardingPage.greetingForWorkout)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }.backgroundColor(.backgroundColor)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewInterfaceOrientation(.portrait)
    }
}
