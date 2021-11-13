//
//  SideEffectOnboardingViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 13/11/21.
//

import SwiftUI

final class SideEffectOnboardingViewModel: ObservableObject {
    @Binding
    var page: OnboardingPage
    let title: LocalizedStringKey
    let text: LocalizedStringKey
    let image: Image
    let peformSideEffect: () -> Void
    
    init(page: Binding<OnboardingPage>,
         title: LocalizedStringKey,
         text: LocalizedStringKey,
         image: Image,
         _ sideEffect: @escaping () -> Void) {
        
        self._page = page
        self.title = title
        self.text = text
        self.image = image
        self.peformSideEffect = sideEffect
    }
    
    func skip() {
        page = page.next()
    }
    
    func next() {
        peformSideEffect()
        page = page.next()
    }
}
