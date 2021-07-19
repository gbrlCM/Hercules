//
//  StringKeys.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

enum StringKey: String {
    //MARK: Feed sections
    case thisWeek = "This week"
    case thisWeekEmpty = "This week empty"
    case statsHighlights = "Stats highlights"
    case previousWorkouts = "Previous Workouts"
    
    //MARK: Days of the week
    case today = "Today"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wedenesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    
    //MARK: Workout Creation
    case daysOfTheWeek = "Days of the week"
    
    //MARK: Miscelaneous
    case addWorkout = "Add workout"
}

extension LocalizedStringKey {
    
    init(_ key: StringKey) {
        self.init(key.rawValue)
    }
}
