//
//  WorkoutDaysSection.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import Foundation
import SwiftUI

struct WorkoutDaysSection: View {
    
    var daysOfTheWeek: [Int]
    var days:[String] = {
        var calendar = Calendar.current
        calendar.locale = Locale.autoupdatingCurrent
        return calendar.veryShortWeekdaySymbols
    }()
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ForEach(0..<days.count) { index in
                Text(days[index])
                    .foregroundColor(daysOfTheWeek.contains(index+1) ? .white : .primary)
                    .fontWeight(.heavy)
                    .frame(width: 36, height: 36, alignment: .center)
                    .background(background(forTagAt: index))
                    .cornerRadius(18)
            }
        }
    }
    
    @ViewBuilder
    func background(forTagAt index: Int) -> some View {
        if(daysOfTheWeek.contains(index+1)) {
            GradientBackground(start: .redGradientStart, finish: .redGradientFinish)
                .withCardShadow()
        } else {
            Color(.tertiarySystemBackground)
                .withCardShadow()
        }
    }
}
