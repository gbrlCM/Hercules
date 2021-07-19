//
//  TagsRequest.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import CoreData

extension ExerciseTags {
    
    static var allTags: NSFetchRequest<ExerciseTags> {
        let request: NSFetchRequest<ExerciseTags> = ExerciseTags.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ExerciseTags.name, ascending: true)]
        
        return request
    }
}
