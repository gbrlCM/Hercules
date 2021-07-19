//
//  Day.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation
import SwiftUI

enum Day: Int, CaseIterable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    
    init?(date: Date) {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        self.init(rawValue: day)
    }
    
    var letter: LocalizedStringKey {
        
        let key: LocalizedStringKey
        
        switch self {
        case .monday: key = LocalizedStringKey("Monday_letter")
        case .tuesday: key = LocalizedStringKey("Tuesday_letter")
        case .wednesday: key = LocalizedStringKey("Wedenesday_letter")
        case .thursday: key = LocalizedStringKey("Thursday_letter")
        case .friday: key = LocalizedStringKey("Friday_letter")
        case .saturday: key = LocalizedStringKey("Saturday_letter")
        case .sunday: key = LocalizedStringKey("Sunday_letter")
        }
        
        return key
    }
    
    var name: LocalizedStringKey {
        
        let key: LocalizedStringKey
        
        switch self {
        case .monday: key = LocalizedStringKey(.monday)
        case .tuesday: key = LocalizedStringKey(.tuesday)
        case .wednesday: key = LocalizedStringKey(.wednesday)
        case .thursday: key = LocalizedStringKey(.thursday)
        case .friday: key = LocalizedStringKey(.friday)
        case .saturday: key = LocalizedStringKey(.saturday)
        case .sunday: key = LocalizedStringKey(.sunday)
        }
        
        return key
    }
    
}
