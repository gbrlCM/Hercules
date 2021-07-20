//
//  ExerciseCreationViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation

class WorkoutCreationViewModel: ObservableObject {
    
    private let dataStorage = DataStorage.shared
    
    @Published
    var daysSelected: [Bool] = Day.allCases.map {_ in false }
    @Published
    var nameField: String = ""
    @Published
    var areaOfFocus: Int = 0
    @Published
    var createdExercises: [WorkoutExercise] = []
    @Published
    var creatingNewItem: Bool = false
    @Published
    var endDate: Date = Date()
    
    let areasOfFocus = ExerciseFocusArea.allCases
    
    func saveExercise(_ exercise: WorkoutExercise) {
//        let exercise = ADWorkoutExercise(context: DataStorage.shared.persistentContainer.viewContext)
//        exercise.exercise = exerciseName
//        exercise.series = Int32(series)
//        exercise.repetitions = Int32(repetitions)
//        exercise.intesityMetric = Int32(intesityType)
//        exercise.intesityValue = intesityValue
//        exercise.restTime = restTime
//        createdExercises.append(exercise)
//        creatingNewItem = false
    }
    
    func saveWorkout() {
//        let workout = ADWorkout(context: dataStorage.persistentContainer.viewContext)
//
//        createdExercises.forEach { exercise in
//            workout.addToExercises(exercise)
//        }
//
//        workout.name = nameField
//        workout.focusArea = Int32(areaOfFocus)
//
//        let days = daysSelected
//                    .enumerated()
//                    .filter {$1 == true}
//                    .map{index, value in index + 1}
//
//        workout.daysOfTheWeek = days
//
//        do {
//            try dataStorage.persistentContainer.viewContext.save()
//            print("""
//                Saved object:
//                name: \(workout.name ?? "nil")
//                days: \(days)
//                areaOfFocus: \(areaOfFocus)
//                exercises: \(createdExercises.map{$0.exercise?.name ?? "nil"})
//                """)
//        } catch {
//            print("faleid saving workout")
//            dataStorage.persistentContainer.viewContext.rollback()
//        }
    }
}
