//
//  WorkoutExecutionHeader.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 26/07/21.
//

import SwiftUI

struct WorkoutExecutionHeader: View {
    var viewModel: ExerciseCreationCellViewModel
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey(viewModel.name))
                .font(.title.bold())
                .foregroundColor(.primary)
            if viewModel.intesityType == .bodyWeight {
                Text("\(viewModel.series, specifier: "%d") x \(viewModel.repetitons, specifier: "%d") at body weight - \(viewModel.restTimeFormatted) of rest")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("\(viewModel.series, specifier: "%d") x \(viewModel.repetitons, specifier: "%d") at \(viewModel.intesityFormatted) - \(viewModel.restTimeFormatted) of rest")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

struct WorkoutExecutionHeader_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutExecutionHeader(viewModel: .init())
    }
}
