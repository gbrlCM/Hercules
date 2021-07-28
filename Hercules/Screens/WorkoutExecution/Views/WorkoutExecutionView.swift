//
//  WorkoutExecutionView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 24/07/21.
//

import SwiftUI

struct WorkoutExecutionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var strokeStyle = StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
    
    @ObservedObject
    var viewModel: WorkoutExecutionViewModel
    
    
    let timeFormatter = ElapsedTimeFormatter()
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            VStack {
                header
                clock
                exercisesList
                buttonsStack
            }.onReceive(viewModel.timer, perform: { _ in
                viewModel.updateTimer()
            })
            .sheet(isPresented: $viewModel.isPresentingExerciseList) {
                
            } content: {
                WorkoutListView(workout: $viewModel.workout, isPresenting: $viewModel.isPresentingExerciseList)
            }
            .sheet(isPresented: $viewModel.isPresentingSummary) {
                presentationMode.wrappedValue.dismiss()
                viewModel.saveWorkoutSession()
            } content: {
                WorkoutSummaryView(workoutName: viewModel.workout.name,
                                   totalTime: viewModel.generalTime,
                                   restTime: viewModel.totalRestTime,
                                   exerciseTime: viewModel.totalExerciseTime,
                                   exerciseCount: viewModel.workout.exercises.count,
                                   seriesCount: viewModel.workout.exercises.map(\.series).reduce(0, +))
                    { viewModel.isPresentingSummary = false }
            }
            
        }
    }
    @ViewBuilder
    var header: some View {
        WorkoutExecutionHeader(viewModel: .init(data: viewModel.currentExercise))
    }
    
    @ViewBuilder
    var clock: some View {
        WorkoutClock(progress: viewModel.restTimeProgress,
                     primaryTimer: viewModel.generalTime,
                     secondaryTimer: viewModel.viewState == .exercise ?
                        viewModel.exerciseTime : viewModel.restTime,
                     isPrimaryTimerInHighlight: {viewModel.viewState == .exercise})
    }
    
    @ViewBuilder
    var exercisesList: some View {
        List {
            Section(header: Text("\(viewModel.currentSerie, specifier: "%d") out of \(viewModel.currentExercise.series, specifier: "%d")")) {
                ForEach(viewModel.doneSeriesTimer.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text("Serie - \(index+1)")
                        Text(NSNumber(value: viewModel.doneSeriesTimer[index]), formatter: timeFormatter)
                    }
                }
                .listRowBackground(Color.backgroundColor)
            }
        }
        .frame(height: 200)
    }
    
    @ViewBuilder
    var buttonsStack: some View {
        HStack {
            quitButton
                .padding(.leading, 12)
            
            Spacer()
            middleButtonsStack
            Spacer()
            
            moreInfoButtonStack
                .padding(.trailing, 12)
        }.padding(.vertical, 8)
    }
    
    @ViewBuilder
    var quitButton: some View {
        Button(action: {viewModel.finishWorkout()}, label: {
            Image(systemName: "xmark")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.all, 12)
                .frame(width: 50, height: 50, alignment: .center)
                .background(Capsule().fill(Color.red))
        })
    }
    
    @ViewBuilder
    var middleButtonsStack: some View {
        ZStack {
            HStack {
                Button(action: {viewModel.skip()}, label: {
                    Text("Skip")
                        .bold()
                        .foregroundColor(.redGradientFinish)
                        .padding(.trailing, 42)
                        .padding(.leading, 16)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.redGradientFinish.opacity(0.25)))
                })
                Button(action: {viewModel.next()}, label: {
                    Text(viewModel.viewState == .exercise ? "Next" : "Start" )
                        .bold()
                        .foregroundColor(.redGradientFinish.opacity(viewModel.isPaused ? 0.1 : 1))
                        .padding(.leading, 42)
                        .padding(.trailing, 16)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.redGradientFinish.opacity(
                            viewModel.isPaused ? 0.1 : 0.25
                        )))
                }).disabled(viewModel.isPaused)
            }
            Button(action: {viewModel.tooglePause()}, label: {
                Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(.all, 18)
                    .background(Capsule().fill(Color.redGradientFinish))
            })
        }
    }
    
    @ViewBuilder
    var moreInfoButtonStack: some View {
        Button(action: {viewModel.isPresentingExerciseList = true}, label: {
            Image(systemName: "note.text")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.all, 12)
                .frame(width: 50, height: 50, alignment: .center)
                .background(Capsule().fill(Color.red))
        })
    }
}

struct WorkoutExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutExecutionView(viewModel: .init(workout: Workout()))
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier: "pt_BR"))
            WorkoutExecutionView(viewModel: .init(workout: Workout()))
                .previewDevice("iPhone SE (2nd generation)")
                .preferredColorScheme(.light)
        }
    }
}
