//
//  StatHighlightBuilder.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 05/08/21.
//

import Foundation

struct StatHighlightCardBuilder {
    
    static func build(for workouts: [Workout]) -> [StatHighlightsCardViewModel] {
        
        let workoutCard = StatHighlightsCardViewModel(stat: "\(workouts.count)",
                                                      description: "Workouts created",
                                                      statType: .neutral)
        
        let sessionCount = workouts.map(\.sessions.count).reduce(0, +)
        
        let sessionCard = StatHighlightsCardViewModel(stat: "\(sessionCount)",
                                                      description: "Previous Sessions",
                                                      statType: .neutral)
        
        let exercisesCount = workouts.map(\.exercises.count).reduce(0, +)
        
        let exercisesCard = StatHighlightsCardViewModel(stat: "\(exercisesCount)",
                                                      description: "Exercises",
                                                      statType: .neutral)
        
        return [workoutCard, sessionCard, exercisesCard]
    }
}
