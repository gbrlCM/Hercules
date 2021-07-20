//
//  TagsMigration.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import CoreData

class TagsMigration: Migration {
    
    let initialTags = ["chest", "glutes", "arm", "shoulder", "abs", "leg", "fullBody", "back"]
    
    func performMigration(to context: NSManagedObjectContext) {
        
        initialTags.forEach { tag in
            let dbTag = ADExerciseTags(context: context)
            
            dbTag.name = tag
            
            do {
                try context.save()
                print("\(tag) saved")
            } catch {
                context.rollback()
                print("fail to save \(tag)")
            }
        }
    }
}
