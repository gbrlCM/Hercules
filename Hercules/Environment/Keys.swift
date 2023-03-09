//
//  Keys.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 01/03/23.
//

import Habitat

private struct WorkoutStorageKey: HabitatKey {
    static var currentValue: WorkoutsStorage = WorkoutsStorageImpl()
}

private struct HealthStorageKey: HabitatKey {
    static var currentValue: HealthStorage = HealthStorageImpl()
}

private struct DateHelperKey: HabitatKey {
    static var currentValue: DatesHelper = DatesHelperImpl()
}

private struct ExerciseStorageKey: HabitatKey {
    static var currentValue: ExerciseStorage = ExerciseStorageImpl()
}

extension Habitat {
    var workoutsStorage: WorkoutsStorage {
        get { Self[WorkoutStorageKey.self] }
        set { Self[WorkoutStorageKey.self] = newValue }
    }
    
    var healthStorage: HealthStorage {
        get { Self[HealthStorageKey.self] }
        set { Self[HealthStorageKey.self] = newValue }
    }
    
    var dateHelper: DatesHelper {
        get { Self[DateHelperKey.self] }
        set { Self[DateHelperKey.self] = newValue }
    }
    
    var exerciseStorage: ExerciseStorage {
        get { Self[ExerciseStorageKey.self] }
        set { Self[ExerciseStorageKey.self] = newValue }
    }
}
