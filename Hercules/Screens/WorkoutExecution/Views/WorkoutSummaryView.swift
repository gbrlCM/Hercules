//
//  WorkoutSummaryView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 27/07/21.
//

import SwiftUI
import Foundation

struct WorkoutSummaryView: View {
    
    var workoutName: String
    var totalTime: TimeInterval
    var restTime: TimeInterval
    var exerciseTime: TimeInterval
    var exerciseCount: Int
    var seriesCount: Int
    var saveButtonAction: (() -> Void)?
    
    private let formatter: DateComponentsFormatter = {
       let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            VStack {
                Text(workoutName)
                    .font(.largeTitle.bold())
                    .padding()
                Spacer()
                VStack {
                    Text("Total time")
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 2)
                    Text(formatter.string(from: totalTime) ?? "")
                        .font(.title.bold())
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.cardBackgroundBasic)
                .cornerRadius(12)
                HStack {
                    HStack {
                        Spacer()
                        VStack {
                            Text("restTime")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 2)
                            Text(formatter.string(from: restTime) ?? "")
                                .font(.title2.bold())
                                .foregroundColor(.pink)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.cardBackgroundBasic)
                    .cornerRadius(12)
                    HStack {
                        Spacer()
                        VStack {
                            Text("Exercise")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 2)
                            Text(formatter.string(from: exerciseTime) ?? "")
                                .font(.title2.bold())
                                .foregroundColor(.pink)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.cardBackgroundBasic)
                    .cornerRadius(12)
                }
                HStack {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Exercises")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 2)
                            Text("\(exerciseCount)")
                                .font(.title.bold())
                                .foregroundColor(.orange)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.cardBackgroundBasic)
                    .cornerRadius(12)
                    HStack {
                        Spacer()
                        VStack {
                            Text("Series")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 2)
                            Text("\(seriesCount)")
                                .font(.title.bold())
                                .foregroundColor(.orange)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.cardBackgroundBasic)
                    .cornerRadius(12)
                }
                Spacer()
                if let action = saveButtonAction {
                    Button {action()} label: {
                        HStack {
                            Spacer()
                            Text("Save")
                                .font(.title3)
                                .bold()
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Capsule().fill(Color.red.opacity(0.25)))
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 8)
        }
    }
}

struct WorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSummaryView(workoutName: "Workout name",
                           totalTime: 12034,
                           restTime: 10000,
                           exerciseTime: 2034,
                           exerciseCount: 8,
                           seriesCount: 36,
                           saveButtonAction: {})
    }
}
