//
//  InitialMigration.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import CoreData

class ExercisesMigration: Migration {
    
    private struct ExerciseMigration: Codable {
        let name: String
        let tags: [String]
    }
    
    var namedTags: [String: ExerciseTags] = [:]
    
    func performMigration(to context: NSManagedObjectContext) {
        let migrationData = PropertyListDecoder.decode("ExercisesData", to: [ExerciseMigration].self)
        
        let request: NSFetchRequest<ExerciseTags> = ExerciseTags.fetchRequest()
        
        guard
            let tags = try? context.fetch(request),
            let unwrapedMigrationData = migrationData
        else {
            print("error")
            return }
        
        
        
        tags.forEach {[unowned self] in
             if let name = $0.name {
                namedTags[name] = $0
            }
        }
        
        unwrapedMigrationData.forEach { exercise in
            let dbExercise = Exercise(context: context)
            dbExercise.name = exercise.name

            exercise.tags.forEach { tag in
                if let exerciseTag = namedTags[tag] {
                    dbExercise.addToTags(exerciseTag)
                }
            }

            do {
                try context.save()
                print("\(dbExercise.name ?? "nil") saved")
            } catch {
                context.rollback()
            }
        }
    }
}
