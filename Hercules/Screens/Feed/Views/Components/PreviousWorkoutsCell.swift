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
        NavigationLink(destination: EmptyView()) {
            EmptyView()
        }
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
                        .foregroundColor(.primary)
                        .padding(.top, 6)
                        .padding(.bottom, 1)
                    text(viewModel.workoutInfo, font: .subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 6)
                }
                .padding(.horizontal, 16)
                .background(Color.cardBackgroundBasic)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.1), radius: 6, x: 4, y: 4)
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
            .preferredColorScheme(.light)
    }
}
