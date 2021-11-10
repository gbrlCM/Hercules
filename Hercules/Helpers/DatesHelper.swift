//
//  DatesHelper.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 21/10/21.
//

import Foundation

protocol DatesHelper {
    
    var todayWeekDay: Int { get }
    var days: [String] { get }
    var today: Date { get }
    
}

extension DatesHelper {
    private var calendar: Calendar {
        var calendar: Calendar = .current
        calendar.locale = .autoupdatingCurrent
        return calendar
    }
    
    var todayWeekDay: Int {
        calendar.component(.weekday, from: today)
    }
    
    var days: [String] {
        calendar.weekdaySymbols
    }
}

struct DatesHelperImpl: DatesHelper {
    var today: Date { Date() }
}

struct DatesHelperMock: DatesHelper {
    
    var offset: TimeInterval = 0
    
    var today: Date { Date(timeIntervalSince1970: offset) }
}
