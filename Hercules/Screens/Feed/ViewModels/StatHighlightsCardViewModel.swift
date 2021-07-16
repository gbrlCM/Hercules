//
//  StatHighlightsCardViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

struct StatHighlightsCardViewModel {
    
    enum StatStatus {
        case improvement
        case neutral
        case decrease
    }
    
    let stat: String
    let description: String
    let status: StatStatus
    
    init() {
        stat = "6%"
        status = .improvement
        description = "increase in 1RM for bench press"
    }
    
    init(stat: String, description: String, statType: StatStatus) {
        self.stat = stat
        self.description = description
        self.status = statType
    }
}
