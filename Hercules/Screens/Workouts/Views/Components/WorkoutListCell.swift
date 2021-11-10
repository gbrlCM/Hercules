//
//  WorkoutListCell.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 27/10/21.
//

import SwiftUI

struct WorkoutListCell: View {
    let exerciseName: String
    let exerciseCount: Int
    let formattedDates: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(exerciseName) - \(exerciseCount) exercises")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(formattedDates)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }
}
