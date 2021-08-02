//
//  ActivityRingData.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 23/07/21.
//

import SwiftUI

struct ActivityRingData: Hashable {
    let name: ActivityType
    let achieved: Double
    let goal: Double
}

enum ActivityType: String {
    case move
    case calories
    case stand
    
    var color: Color {
        let color: Color
        
        switch self {
        case .calories: color = Color("caloriesColor")
        case .move: color = Color("moveColor")
        case .stand: color = Color("standColor")
        }
        
        return color
    }
}
