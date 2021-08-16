//
//  ExerciseCreationCellViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation

struct ExerciseCreationCellViewModel {
    
    let name: String
    let series: Int
    let repetitons: Int
    let intesity: Double
    let intesityType: IntensityType
    let restTime: TimeInterval
    
    private(set) var intesityFormatted: String = ""
    private(set) var restTimeFormatted: String = ""
    
    private var isMetricSystem: Bool {
        let locale = Locale.current
        return locale.usesMetricSystem
    }
    
    init() {
        name = "Leg press"
        series = 4
        repetitons = 12
        intesity = 80
        intesityType = .areaOfRm
        restTime = 90
        intesityFormatted = generateIntesity()
        restTimeFormatted = generateRestTime()
        
    }
    
    init(data: WorkoutExercise) {
        self.name = data.exerciseName
        self.series = data.series
        self.repetitons = data.repetitions
        self.intesity = data.intesityValue
        self.intesityType = data.intesityMetric
        self.restTime = data.restTime
        intesityFormatted = generateIntesity()
        restTimeFormatted = generateRestTime()
    }
    
    private func generateSubtitle() -> String {
        let repsAndSeries = "\(series) x \(repetitons)"
        let intesity = generateIntesity()
        let restTime = generateRestTime()
        let subtitle = "\(repsAndSeries) - \(intesity) - \(restTime)"
        
        return subtitle
    }
    
    private func generateIntesity() -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        
        switch intesityType {
        case .areaOfRm: return "\(intesity)RM"
        case .bodyWeight: return NSLocalizedString("bodyWeight", comment: "Tell that is the weight of the body")
        case .rm1: return "\(intesity)% 1RM"
        case .seconds: return formatter.string(from: Measurement(value: restTime, unit: UnitDuration.seconds))
        case .weight:
            if isMetricSystem {
                return formatter.string(from: Measurement(value: intesity, unit: UnitMass.kilograms))
            } else {
                return formatter.string(from: Measurement(value: intesity, unit: UnitMass.pounds))
            }
        }
    }
    
    private func generateRestTime() -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        
        let time = formatter.string(from: Measurement(value: restTime, unit: UnitDuration.seconds))
        
        return time
    }
}
