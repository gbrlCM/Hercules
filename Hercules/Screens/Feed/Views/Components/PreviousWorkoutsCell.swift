//
//  PreviousWorkoutsCell.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import SwiftUI

struct PreviousWorkoutsCell: View {
    
    var viewModel: PreviousWorkoutCellViewModel
    
    var body: some View {
        NavigationLink(
            destination: WorkoutSummaryView(workoutName: viewModel.session.workoutName,
                                            totalTime: viewModel.session.totalTime,
                                            restTime: viewModel.session.restTime,
                                            exerciseTime: viewModel.session.exerciseTime,
                                            exerciseCount: viewModel.session.exerciseCount,
                                            seriesCount: viewModel.session.seriesCount,
                                            saveButtonAction: nil),
            label: {
                VStack {
                    text(viewModel.dateOfWorkout, font: .title3.bold())
                        .padding(.vertical, 4)
                    text(viewModel.workoutInfo, font: .subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                }.padding(.horizontal, 16)
            })
    }
    
    @ViewBuilder
    func text(_ text: String, font: Font) -> some View {
        HStack {
            Text(text)
                .font(font)
            Spacer()
        }
    }
}

struct LastWorkoutsCell_Previews: PreviewProvider {
    static var previews: some View {
        PreviousWorkoutsCell(viewModel: .init())
    }
}
