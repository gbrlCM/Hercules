//
//  ArnoldOnboardingViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/11/21.
//

import SwiftUI

class ArnoldOnboardingViewModel: ObservableObject {
    @Binding
    var page: OnboardingPage
    let title: LocalizedStringKey
    let text: LocalizedStringKey
    
    init(page: Binding<OnboardingPage>, title: LocalizedStringKey, text: LocalizedStringKey) {
        self._page = page
        self.title = title
        self.text = text
    }
    
    func next() {
        page = page.next()
    }
}
