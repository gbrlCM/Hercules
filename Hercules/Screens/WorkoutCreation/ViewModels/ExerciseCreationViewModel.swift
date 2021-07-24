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
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isButtonDisabledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($repsString, $restTimeString, $intesityString)
            .map { (repsString, restTimeString, intesityString) -> Bool in
                guard
                    !repsString.isEmpty,
                    NumberFormatter().number(from: repsString) as? Int != nil,
                    !restTimeString.isEmpty,
                    NumberFormatter().number(from: restTimeString) as? Double != nil,
                    !intesityString.isEmpty,
                    NumberFormatter().number(from: intesityString) as? Double != nil
                else { return true }
                return false
            }
            .eraseToAnyPublisher()
    }
    //    var workoutExercise: WorkoutExercise {
    //
    //    }
    
    var createdExercise: WorkoutExercise {
        guard let id = UUID(uuidString: exercise.id) else {
            preconditionFailure("ID saved incorrectily, please revise the id of the exercise")
        }
        
        guard let intesityMetric = IntensityType(rawValue: measurementIndex) else {
            preconditionFailure("Error fetch correct intesity, please revise picker or Intesity type model")
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
            return -1
        }
        
        return number
    }
    
    private var intesity: Double {
        guard let number = NumberFormatter().number(from: intesityString)?.doubleValue else {
            return -1
        }
        
        return number
    }
    
    private var restTime: Double {
        guard let number = NumberFormatter().number(from: restTimeString)?.doubleValue else {
            return -1
        }
        
        return number
    }
    
    
}
