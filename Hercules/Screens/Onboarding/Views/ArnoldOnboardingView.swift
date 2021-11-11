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
    @Environment(\.sizeCategory)
    var sizeCategory
    
    var body: some View {
        VStack {
            Spacer()
            ChatBalloon {
                if sizeCategory >= .extraLarge {
                    balloonContentForLargeSize
                } else {
                    balloonContent
                }
            }
            .padding()
            Image("ArnoldGradient")
                .padding(.top, 32)
            Spacer()
            buttonsSection
        }
    }
    
    @ViewBuilder
    var balloonContent: some View {
        VStack {
            Text(viewModel.title)
                .foregroundColor(.redGradientStart)
                .font(.title.bold())
                .padding(.bottom, 2)
            Text(viewModel.text)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    var balloonContentForLargeSize: some View {
        ScrollView(.vertical, showsIndicators: true) { balloonContent }
    }
    
    @ViewBuilder
    var buttonsSection: some View {
        HStack {
            Spacer()
            Button(action: { dismiss() }, label: {
                Text("Skip")
                    .font(.system(size: 18))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
            })
                .buttonStyle(.bordered)
                .tint(.redGradientStart)
            Spacer()
            Button(action: viewModel.next, label: {
                Text("Next")
                    .font(.system(size: 18))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
            })
                .buttonStyle(.bordered)
                .tint(.redGradientStart)
            Spacer()
        }.padding()
    }
}

struct ArnoldOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ArnoldOnboardingView(viewModel: .init(page: .constant(.greeting), title: .init("Welcome"), text: .init("I’m here to help you reach your full fitness potential. And how am I gonna do that? 🤔 \n \n I will store your workouts, tell you when your rest time is over and show you your weekly scheadule. \n \n If you want to know more press next!")))
    }
}
