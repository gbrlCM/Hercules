//
//  WorkoutClock.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 26/07/21.
//

import SwiftUI
import Combine

struct WorkoutClock: View {
    
    var progress: Double
    var primaryTimer: TimeInterval
    var secondaryTimer: TimeInterval
    
    var isPrimaryTimerInHighlight: () -> Bool
    
    let strokeStyle = StrokeStyle(lineWidth: 20,
                                  lineCap: .round,
                                  lineJoin: .round)
    
    let generalTimeFormatter = ElapsedTimeFormatter()
    let secondaryTimeFormatter: ElapsedTimeFormatter = {
        let formatter = ElapsedTimeFormatter()
        formatter.showSubseconds = false
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: strokeStyle)
                .padding(32)
                .foregroundColor(.timerBackground)
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(style: strokeStyle)
                .foregroundColor(.red)
                .padding(32)
            clockTexts
            
        }
    }
    
    @ViewBuilder
    var clockTexts: some View {
        VStack {
            Text("Workout")
            Text(NSNumber(value: primaryTimer), formatter: generalTimeFormatter)
                .font(.monospacedDigit(isPrimaryTimerInHighlight() ? .largeTitle : .title3)())
                .fontWeight(.heavy)
                .animation(.easeInOut)
                .padding(.bottom, 4)
            
            Text(isPrimaryTimerInHighlight() ? "Exercise" : "restTime")
            Text(NSNumber(value: secondaryTimer), formatter: secondaryTimeFormatter)
                .font(.monospacedDigit(isPrimaryTimerInHighlight() ? .title3 : .largeTitle)())
                .fontWeight(.heavy)
                .animation(.easeInOut)
                .foregroundColor(progress < 0 ? .redGradientStart : .primary)
        }
    }
    
    
}

struct WorkoutClock_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutClock(progress: 0.5,
                     primaryTimer: 100,
                     secondaryTimer: 30) { true }
    }
}
