//
//  DaysSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation

struct DaysSectionViewModel {
    
    var elementCount: Int
    var sectionTitle: StringKey
    var days: [Day]
    
    init() {
        days = Day.allCases
        elementCount = days.count
        sectionTitle = .daysOfTheWeek
    }
}
