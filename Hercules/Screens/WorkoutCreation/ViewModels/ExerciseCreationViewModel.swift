//
//  ExerciseCreationViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 20/07/21.
//

import Combine
import Foundation

class ExerciseCreationViewModel: ObservableObject {
    
    @Published
    var series: Int = 1
    @Published
    var repsString: String = ""
    @Published
    var measurementIndex: Int = 0
    @Published
    var restTimeString: String = ""
    @Published
    var intesityString: String = ""
    @Published
    var didFinishRegistering: Bool = false
    @Published
    var isButtonDisabled: Bool = true
    @Published
    var exercise: Exercise
    
    var measurementStyles = IntensityType.allCases
    var dismiss: () -> Void = { fatalError("uninplemented") }
    var save: (WorkoutExercise) -> Void = { _ in fatalError("uninplemented") }
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isButtonDisabledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4($repsString, $restTimeString, $intesityString, $measurementIndex)
            .map(ExerciseCreationViewModel.isButtonDisabled)
            .eraseToAnyPublisher()
    }
    
    var intesityMetric: IntensityType {
        guard let intesityMetric = IntensityType(rawValue: measurementIndex) else {
            preconditionFailure("Error fetch correct intesity, please revise picker or Intesity type model")
        }
        
        return intesityMetric
    }
    
    var createdExercise: WorkoutExercise {
        guard let id = UUID(uuidString: exercise.id) else {
            preconditionFailure("ID saved incorrectily, please revise the id of the exercise")
        }
        
        return WorkoutExercise(exerciseName: exercise.name,
                               exerciseID: id,
                               intesityMetric: intesityMetric,
                               intesityValue: intesity,
                               repetitions: reps,
                               series: series,
                               restTime: restTime)
    }
    
    init(exercise: Exercise) {
        self.exercise = exercise
        isButtonDisabledPublisher
            .assign(to: \.isButtonDisabled, on: self)
            .store(in: &cancellables)
    }
    
    private var reps: Int {
        guard let number = NumberFormatter().number(from: repsString)?.intValue else {
            return 1
        }
        
        return number
    }
    
    private var intesity: Double {
        guard let number = NumberFormatter().number(from: intesityString)?.doubleValue else {
            return 1
        }
        
        return number
    }
    
    private var restTime: Double {
        guard let number = NumberFormatter().number(from: restTimeString)?.doubleValue else {
            return 50
        }
        
        return number
    }
    
    func selectExerciseButtonTapped() {
        dismiss()
    }
    
    func saveExerciseButtonTapped() {
        let exercise = self.createdExercise
        save(exercise)
    }
}

extension ExerciseCreationViewModel {
    
    private static func isButtonDisabled(repsString: String, restTimeString: String, intesityString: String, measurementIndex: Int) -> Bool {
        guard
            let measurementMetric = IntensityType(rawValue: measurementIndex)
        else { return true }
        
        let isDisabled: Bool
        let formatter = NumberFormatter()
        
        if measurementMetric == .seconds || measurementMetric == .areaOfRm {
            isDisabled = !restTimeString.isEmpty &&
                formatter.number(from: restTimeString) as? Double != nil &&
                !intesityString.isEmpty &&
                formatter.number(from: intesityString) as? Double != nil
        } else if measurementMetric == .bodyWeight {
            isDisabled = !repsString.isEmpty &&
                formatter.number(from: repsString) as? Int != nil &&
                !restTimeString.isEmpty &&
                formatter.number(from: restTimeString) as? Double != nil
        } else {
            isDisabled = !repsString.isEmpty &&
                formatter.number(from: repsString) as? Int != nil &&
                !restTimeString.isEmpty &&
                formatter.number(from: restTimeString) as? Double != nil &&
                !intesityString.isEmpty &&
                formatter.number(from: intesityString) as? Double != nil
        }
        
        return !isDisabled
    }
}
