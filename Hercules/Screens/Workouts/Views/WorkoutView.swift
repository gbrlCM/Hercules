//
//  WorkoutView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import SwiftUI

struct WorkoutView: View {
    
    var workout: Workout
    var days:[String] = {
        var calendar = Calendar.current
        calendar.locale = Locale.autoupdatingCurrent
        return calendar.veryShortWeekdaySymbols
    }()
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            WorkoutDaysSection(daysOfTheWeek: workout.daysOfTheWeek)
        }.navigationTitle(Text(LocalizedStringKey(workout.name)))
    }
    
    @ViewBuilder
    func background(forTagAt index: Int) -> some View {
        if(workout.daysOfTheWeek.contains(index+1)) {
            GradientBackground(start: .redGradientStart, finish: .redGradientFinish)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
        } else {
            Color(.tertiarySystemBackground)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutView(workout: Workout())
                .preferredColorScheme(.dark)
            WorkoutView(workout: Workout())
        }
    }
}
