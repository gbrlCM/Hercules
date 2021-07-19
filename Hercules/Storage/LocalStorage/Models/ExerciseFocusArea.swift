//
//  ExerciseFocusArea.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import SwiftUI

enum ExerciseFocusArea: Int, CaseIterable {
    case leg
    case chest
    case back
    case arm
    case shoulder
    case fullBody
    case push
    case pull
    case upperBody
    case lowerBody
    
    var name: LocalizedStringKey {
        
        let key: LocalizedStringKey
        
        switch self {
        case .arm: key = LocalizedStringKey("arm")
        case .back: key = LocalizedStringKey("back")
        case .chest: key = LocalizedStringKey("chest")
        case .fullBody: key = LocalizedStringKey("fullBody")
        case .leg: key = LocalizedStringKey("leg")
        case .lowerBody: key = LocalizedStringKey("lowerBody")
        case .pull: key = LocalizedStringKey("pull")
        case .push: key = LocalizedStringKey("push")
        case .shoulder: key = LocalizedStringKey("shoulder")
        case .upperBody: key = LocalizedStringKey("upperBody")
        }
        
        return key
    }
}
