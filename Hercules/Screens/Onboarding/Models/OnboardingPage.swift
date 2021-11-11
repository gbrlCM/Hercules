//
//  OnboardingPage.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/11/21.
//

import Foundation

enum OnboardingPage: Int, CaseIterable {
    case greeting, notification, health, greetingForWorkout
    
    func next() -> OnboardingPage {
        let next = rawValue + 1
        if let page = OnboardingPage(rawValue: next) {
            return page
        } else {
            return self
        }
    }
}
