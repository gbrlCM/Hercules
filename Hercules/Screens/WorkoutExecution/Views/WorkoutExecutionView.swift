//
//  WorkoutExecutionView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 24/07/21.
//

import SwiftUI

struct WorkoutExecutionView: View {
    @State
    var limit: TimeInterval = 10
    @State
    var timer: TimeInterval = 4.0
    
    var timerPublisher = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    var strokeStyle = StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
    
    var progress: Double {
        timer/limit
    }
    
    var body: some View {
        MainView(background: Color.backgroundColor) {
            VStack {
                header
                clock
                exercisesList
                buttonsStack
            }.onReceive(timerPublisher, perform: { _ in
                if limit > timer {
                    timer += (1/60)
                }
            })
            
        }
    }
    @ViewBuilder
    var header: some View {
        Text("Weight Squats")
            .font(.title.bold())
        Text("4 x 12 - 80% 1RM")
    }
    
    @ViewBuilder
    var clock: some View {
        ZStack {
            Circle()
                .stroke(style: strokeStyle)
                .padding(24)
                .foregroundColor(.timerBackground)
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(style: strokeStyle)
                .foregroundColor(.red)
                .animation(.easeInOut)
                .padding(24)
            Text(NSNumber(value: timer), formatter: ElapsedTimeFormatter())
                .fontWeight(.heavy)
                .font(.largeTitle)
            
        }
    }
    
    @ViewBuilder
    var exercisesList: some View {
        List {
            Section(header: Text("2 out of 4")) {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading) {
                        Text("1st Serie")
                        Text("01:24")
                    }
                }
            }
        }.frame(height: 200)
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
        Button(action: {}, label: {
            Image(systemName: "xmark")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.all, 12)
                .background(Capsule().fill(Color.red))
        })
    }
    
    @ViewBuilder
    var middleButtonsStack: some View {
        ZStack {
            HStack {
                Button(action: {}, label: {
                    Text("Skip")
                        .bold()
                        .foregroundColor(.redGradientFinish)
                        .padding(.trailing, 42)
                        .padding(.leading, 16)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.redGradientFinish.opacity(0.25)))
                })
                Button(action: {}, label: {
                    Text("Next")
                        .bold()
                        .foregroundColor(.redGradientFinish)
                        .padding(.leading, 42)
                        .padding(.trailing, 16)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.redGradientFinish.opacity(0.25)))
                })
            }
            Button(action: {}, label: {
                Image(systemName: "play.fill")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(.all, 18)
                    .background(Capsule().fill(Color.redGradientFinish))
            })
        }
    }
    
    @ViewBuilder
    var moreInfoButtonStack: some View {
        Button(action: {}, label: {
            Image(systemName: "xmark")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.all, 12)
                .background(Capsule().fill(Color.red))
        })
    }
}

struct WorkoutExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutExecutionView()
                .preferredColorScheme(.light)
            WorkoutExecutionView()
                .previewDevice("iPhone SE (2nd generation)")
                .preferredColorScheme(.light)
        }
    }
}

class ElapsedTimeFormatter: Formatter {
    
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var showSubseconds = true
    
    override func string(for obj: Any?) -> String? {
        guard
            let time = obj as? TimeInterval,
            let formattedStrings = componentsFormatter.string(from: time)
        
        else {
            return nil
        }
        
        if self.showSubseconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedStrings, decimalSeparator, hundredths)
        }
        
        return formattedStrings
    }
}
